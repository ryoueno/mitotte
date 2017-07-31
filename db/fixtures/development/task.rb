180.times do |i|
  Task.seed do |s|
    s.project_id = i / 30 + 1
    s.subject = Faker::Pokemon.name + "を捕まえる"
    s.description = Faker::Pokemon.name + "を捕まえて、育成する"
    s.status = TaskStatus::get.values.sample
  end
end
