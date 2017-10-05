# すべてのタスクに同じスケジュール
25.times do |i|
  # Today, AllTime
  Schedule.seed do |s|
    s.task_id = i + 1
    s.date = Date.today
    s.time = [
      {"00:00" => "23:59"},
    ]
  end
  # Yesterday, 2h * 2
  Schedule.seed do |s|
    s.task_id = i + 1
    s.date = Date.yesterday
    s.time = [
      {"10:00" => "12:00"},
      {"16:00" => "18:00"},
    ]
  end
  # Tomorrow, 2h * 2
  Schedule.seed do |s|
    s.task_id = i + 1
    s.date = Date.tomorrow
    s.time = [
      {"08:00" => "10:00"},
      {"20:00" => "22:00"},
    ]
  end
end
