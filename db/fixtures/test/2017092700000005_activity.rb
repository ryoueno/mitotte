# Behavior id list
behavior_ids = Hash[Behavior.all.map { |row| [row.name, row.id] }]

# Task status id list
task_status_ids = Hash[TaskStatus.all.map { |row| [row.name, row.id] }]

# CHANGE_STATUS
# Task:1 | INITIAL => PENDING => PROGLESS => DONE
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 1
  s.update_from = task_status_ids['INITIAL']
  s.update_to = task_status_ids['PENDING']
  s.created_at = 26.hours.ago
end
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 1
  s.update_from = task_status_ids['PENDING']
  s.update_to = task_status_ids['PROGLESS']
  s.created_at = 25.hours.ago
end
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 1
  s.update_from = task_status_ids['PROGLESS']
  s.update_to = task_status_ids['DONE']
  s.created_at = 1.days.ago
end

# Task:2 | INITIAL => PENDING
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 2
  s.update_from = task_status_ids['INITIAL']
  s.update_to = task_status_ids['PENDING']
  s.created_at = 1.days.ago
end

# Task:3 | INITIAL => PROGLESS
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 3
  s.update_from = task_status_ids['INITIAL']
  s.update_to = task_status_ids['PROGLESS']
  s.created_at = 1.days.ago
end

#task:4 | INITIAL => DONE
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 4
  s.update_from = task_status_ids['INITIAL']
  s.update_to = task_status_ids['DONE']
  s.created_at = 1.days.ago
end

# Task:5 | INITIAL => REJECTED
Activity.seed do |s|
  s.user_id = 1
  s.behavior_id = behavior_ids['CHANGE_STATUS']
  s.target_id = 5
  s.update_from = task_status_ids['INITIAL']
  s.update_to = task_status_ids['REJECTED']
  s.created_at = 1.days.ago
end
