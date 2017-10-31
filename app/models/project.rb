class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user
  validates :subject, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 200 }

  def all_task_num
    self.tasks.count
  end

  def todo_tasks(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    self.tasks.select {|t| t.todo_at?(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule)}
  end

  # Return Progress data in array.
  # Set zero if given date object is invalid.
  # @param [] date label in array, e.g. [0 => Date, 1 => Date, 2 => Date...]
  # @return [Array] progress data
  def progress(date_label, max_data = 1)
    progress = []
    todo_minutes_all = self.todo_minutes(date: self.start_on, time: Tod::TimeOfDay.new(0, 0), ignore_schedule: true).to_f
    date_label.each do |idx, date|
      date = date.to_date
      if date.instance_of?(Date)
        todo_minutes_at_that_time = self.todo_minutes(date: date, time: Tod::TimeOfDay.new(23, 59), ignore_schedule: true)
        progress.push(((todo_minutes_all - todo_minutes_at_that_time).to_f) / todo_minutes_all * max_data)
      else
        progress.push(0)
      end
    end
    progress
  end

  def days
    (self.end_on - self.start_on).to_i
  end

  def hours
    self.tasks.map {|t| t.hours}.sum
  end

  def minutes
    self.tasks.map {|t| t.minutes}.sum
  end

  def seconds
    self.tasks.map {|t| t.seconds}.sum
  end

  def todo_hours(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    self.todo_tasks(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule).map {|t| t.hours}.sum
  end

  def todo_minutes(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    self.todo_tasks(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule).map {|t| t.minutes}.sum
  end

  def todo_seconds(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    self.todo_tasks(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule).map {|t| t.seconds}.sum
  end

  def todo_at?(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    date ||= Date.today
    time ||= Tod::TimeOfDay(Time.now)
    self.tasks.each do |t|
      return true if t.todo_at?(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule)
    end
    return false
  end
end
