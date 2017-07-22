class Schedule < ApplicationRecord
  belongs_to :task

  TIME_TERMS = 3

  scope :todays_users_schedules, -> user_id {
    joins({:task => :project}).where("projects.user_id" => user_id, :date => Date.today)
  }

  def time
    time_sets = JSON.parse self.time_before_type_cast
    time_sets.map {|time| ScheduleTime.new(self.date, time) }
  end

  def seconds
    self.time.map {|t| t.end_at - t.start_at }.sum.to_i
  end

  def minutes
    self.seconds / 60
  end

  def hours
    self.seconds / (60 * 60)
  end
end
