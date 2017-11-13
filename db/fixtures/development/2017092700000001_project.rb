9.times do |i|
  Project.seed do |s|
    rand_str = Faker::Pokemon.unique.location
    s.user_id = i / 3 + 1
    s.subject = rand_str + "プロジェクト"
    s.description = rand_str + "で活躍するために必要なスキルを身につけるためのプロジェクトです。"
    s.start_on = Date.today
    s.end_on = (10 + i).days.since
  end
end
