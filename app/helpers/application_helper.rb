module ApplicationHelper
  def time_of_day(time)
    Tod::TimeOfDay.parse(time)
  end
end
