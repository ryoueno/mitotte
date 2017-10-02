class Task < ApplicationRecord
  belongs_to :project
  has_many :schedules

  # 初期のステータス
  DEFAULT_STATUS = 'INITIAL'

  # 未完了とみなされるステータス
  TODO_STATUSES = [
    'INITIAL',
    'PENNDING',
    'PROGLESS',
  ]

  # 現状のステータスをアクティビティログから計算、なければデフォルトステータス
  def status
    activity = Activity.where_behavior('CHANGE_STATUS').where({target_id: self.id}).order('created_at desc').first
    default_status_id = TaskStatus.where({name: DEFAULT_STATUS}).first.id
    TaskStatus.find(activity&.update_to || default_status_id)
  end

  def next_schedule_date
    s = self.schedules.where('date >= ?', Date.today).order(:date).first
    s.nil? ? nil : s.date
  end

  def next_schedule_time
    s = self.schedules.where('date >= ?', Date.today).order(:date).first
    s.nil? ? nil : s.time[0].start_at
  end

  def seconds
    self.schedules.map {|s| s.seconds}.sum
  end

  def hours
    self.schedules.map {|s| s.hours}.sum
  end

  def minutes
    self.schedules.map {|s| s.minutes}.sum
  end

  # ステータスが作業すべき状態(todo) であるか
  def todo?
    TODO_STATUSES.include?(self.status.name)
  end

  # 与えられた時間において、作業すべきかどうか
  def todo_at?(date: nil, time: nil, ignore_status: false)
    date ||= Date.today
    time ||= Tod::TimeOfDay(Time.now)
    # 指定の時間に作業スケジュールが設定されているかどうか判定
    is_todo = false
    self.schedules.where(:date => date).each do |s|
      is_todo = true if s.todo_at?(time)
    end

    # ignore_status = false の場合、タスクのステータスを無視してスケジュールだけを判定
    if (ignore_status)
      return is_todo
    else
      return self.todo? && is_todo
    end
  end
end
