180.times do |i|
  Activity.seed do |s|
    s.user_id = 1
    s.behavior_id = Behavior::all.sample.id
    s.target_id = Task::all.sample.id
    s.update_from = TaskStatus::all.sample.id
    s.update_to = TaskStatus::all.sample.id
  end
end
