class Schedule < ApplicationRecord
  belongs_to :task

  TIME_TERMS = 3

  scope :todays_users_schedules, -> user_id {
    joins({:task => :project}).where("projects.user_id" => user_id, :date => Date.today)
  }

  def time
    time_sets = JSON.parse self.time_before_type_cast
    time_sets.map {|time| ScheduleTime.new(time) }
  end

  def seconds
    self.time.map {|t| (t.end_at - t.start_at).to_i }.sum
  end

  def minutes
    self.seconds / 60
  end

  def hours
    self.seconds / (60 * 60)
  end

  def todo_at?(time)
    self.time.each do |time_set|
      return true if (time_set.start_at <= time and time_set.end_at > time)
    end
    return false
  end
end
