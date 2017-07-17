class Schedule < ApplicationRecord
  belongs_to :task
  scope :todays_users_schedules, -> user_id {
    joins({:task => :project}).where("projects.user_id" => user_id, :date => Date.today)
  }

  def time
    time_sets = JSON.parse self.time_before_type_cast
    time_sets.map {|time| ScheduleTime.new(self.date, time) }
  end
end
