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

  def progress
    prg = []
    # prg[0] = 0
    # gruff_period.each_with_index do |t, idx|
    #   #prg[idx + 1] = idx * 200
    #   prg[idx + 1] = idx * 200
    # end
    prg = [0, 20, 100, 100, 120, 330, 1000]
    prg
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

  def todo_hours
    self.todo_tasks.map {|t| t.hours}.sum
  end

  def todo_minutes
    self.todo_tasks.map {|t| t.minutes}.sum
  end

  def todo_seconds
    self.todo_tasks.map {|t| t.seconds}.sum
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
