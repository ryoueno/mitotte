class ScheduleTime
  include Tod
  attr_reader :start_at, :end_at

  def initialize(time_set)
    @start_at = TimeOfDay.parse(time_set.keys[0])
    @end_at = TimeOfDay.parse(time_set.values[0])
  end
end
