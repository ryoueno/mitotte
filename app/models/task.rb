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
end
