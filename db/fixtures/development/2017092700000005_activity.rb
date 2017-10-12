date1 = 12.hours.ago
date2 = 12.hours.since
180.times do |i|
  Activity.seed do |s|
    s.user_id = 1
    s.behavior_id = Behavior::all.sample.id
    s.target_id = Task::all.sample.id
    s.update_from = TaskStatus::all.sample.id
    s.update_to = TaskStatus::all.sample.id
    s.created_at = rand(date1..date2)
  end
end
