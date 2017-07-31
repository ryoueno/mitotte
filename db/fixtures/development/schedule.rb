600.times do |i|
  Schedule.seed do |s|
    s.task_id = rand(i/20 + 1) + (i/4) + 1
    s.date = rand(26).days.since
    s.time = [
      {sprintf("%02d:00", rand(6)) => sprintf("%02d:00", rand(6) + 6)},
      {sprintf("%02d:00", rand(6) + 12) => sprintf("%02d:00", rand(6) + 18)}
    ]
  end
end
