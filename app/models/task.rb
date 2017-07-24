class Task < ApplicationRecord
  belongs_to :project
  has_many :schedules

  def status
    TaskStatus.new self.status_before_type_cast
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

  def todo?(date, time)
    self.schedules.where(:date => date).each do |s|
      return true if s.todo? time
    end
    return false
  end
end
