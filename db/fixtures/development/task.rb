180.times do |i|
  Task.seed do |s|
    s.project_id = i / 30 + 1
    s.task_status_id = TaskStatus::all.sample.id
    s.subject = Faker::Pokemon.name + "を捕まえる"
    s.description = Faker::Pokemon.name + "を捕まえて、育成する"
  end
end
