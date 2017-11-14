class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :behavior

  # 600秒毎に集計
  @@second_per_group = 600

  # behavior.nameで絞り込み
  scope :where_behavior, -> status_name {
    joins(:behavior).where("behaviors.name" => status_name)
  }

  # 指定された日の作業ステータス一覧を集計して配列で返す
  # フォーマット
  #  [
  #    '10:00' => Activity row
  #    '12:00' => Activity row
  #  ]
  #
  scope :aggregate, -> user_id, date {
    rows = find_by_sql(["SELECT count(*), MIN(behavior_id) as behavior_id, tasks.subject as subject, activities.created_at FROM activities LEFT JOIN tasks ON target_id = tasks.id where user_id = ? AND DATE(activities.created_at) = ? GROUP BY TRUNCATE(UNIX_TIMESTAMP(activities.created_at) / ?, 0)", user_id, date, @@second_per_group])
    activities = {}
    (0..23).each do |hour|
      0.step(50, 10) do |minute|
        activities[sprintf("%02d:%02d", hour, minute)] = nil
      end
    end
    rows.each do |row|
      # 28分 -> 20分
      minute = (row.created_at.min.to_f / 10).floor * 10
      activities[row.created_at.change(min: minute).strftime("%H:%M")] = row
    end
    return activities
  }

  # 活動内容を日本語文字列にして返す
  def display
    task = Task.find_by_id(self.target_id)
    case self.behavior.name
    when 'RESTING'
      '休憩しています'
    when 'WORKING'
      task.nil? ? "作業をしています" : "「#{task.subject}」を実施しています"
    when 'MOVING'
      'アプリケーションの操作中です'
    when 'LAZY'
      if (self.meta['message'].present? && self.meta['info'])
        "#{self.meta['message']}\n => #{self.meta['info'].join(', ')}"
      else
        'サボっているみたいです'
      end
    when 'RUNNING'
      'アプリケーションが作動中です'
    when 'CHANGE_STATUS'
      status_from = TaskStatus.find_by_id(self.update_from)
      status_to = TaskStatus.find_by_id(self.update_to)
      status_from.nil? or status_to.nil? or task.nil? ? "作業のステータスが更新されました" : "#{task.subject}のステータスが「#{status_from.display}」から「#{status_to.display}」に更新されました"
    when 'CHANGE_SCHEDULE'
      task.nil? ? "予定が変更されました" : "#{task.subject}の予定が変更されました"
    else
      '不明な動作が検出されました'
    end
  end

  def self.interpret(detection)
    user = detection.screenshot.user

    meta = case detection.mode
    when 'LOGO_DETECTION'
      {
        'message' => 'あやしい動きを検知しました [LOGO_DETECTION]',
        'info' => detection.keywords,
      }

    when 'SAFE_SEARCH_DETECTION'
      if (detection.keywords['adult'] != 'VERY_UNLIKELY' && detection.keywords['adult'] != 'UNLIKELY')
        {
          'message' => '高揚している可能性があります',
          'info' => ['adult', detection.keywords['adult']],
        }
      end
    when 'LABEL_DETECTION'
      # 無効なキーワードを抽出
      positive_words = PositiveWord.pluck('display')
      invalid_words = detection.keywords - positive_words

      # 3つ以上含んだらアラート
      if (invalid_words.length >= 3)
        {
          'message' => 'あやしい動きを検知しました [LABEL_DETECTION]',
          'info' => invalid_words,
        }
      end

    end

    if (meta.present? && meta['message'].present? && meta['info'].present?)
      self.create(
        :user_id => user.id,
        :behavior_id => Behavior.find_by({:name => 'LAZY'}).id,
        :meta => meta,
      )
    end
  end
end
