class ScheduleTime
  attr_reader :start_at, :end_at

  def initialize(date, time_set)
    @start_at = Time.parse(date.to_s + " " + time_set.keys[0])
    @end_at = Time.parse(date.to_s + " " + time_set.values[0])
  end
end
