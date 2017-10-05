class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :behavior

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
  scope :aggregate, -> date {
    rows = find_by_sql(["SELECT count(*), MIN(behavior) as behavior, tasks.subject as subject, activities.created_at FROM activities LEFT JOIN tasks ON task_id = tasks.id where DATE(activities.created_at) = ? GROUP BY TRUNCATE(UNIX_TIMESTAMP(activities.created_at) / ?, 0)", date, @@second_per_group])
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
end
