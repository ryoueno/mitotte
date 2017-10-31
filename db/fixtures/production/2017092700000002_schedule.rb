# 全員に同じスケジュール
users = User.all

start_on = Date.new(2017, 10, 31)
end_on = Date.new(2017, 12, 10)

# スケジュール

# 2章 10.31 ~ 11.1
start_on_2 = Date.new(2017, 10, 31)
end_on_2   = Date.new(2017, 11, 1)

# 3章 10.31 ~ 11.7
start_on_3 = Date.new(2017, 10, 31)
end_on_3   = Date.new(2017, 11, 7)

# 4章 10.31 ~ 11.14
start_on_4 = Date.new(2017, 10, 31)
end_on_4   = Date.new(2017, 11, 14)

# 5章 11.7 ~ 11.21
start_on_5 = Date.new(2017, 11, 7)
end_on_5   = Date.new(2017, 11, 21)

# 1章 11.14 ~ 11.28
start_on_1 = Date.new(2017, 11, 14)
end_on_1   = Date.new(2017, 11, 28)

# 抄録 11.21 ~ 12.10
start_on_s = Date.new(2017, 11, 21)
end_on_s   = Date.new(2017, 12, 10)

users.each do |u|
  (start_on..end_on).each do |date|
    case date
    # 2章
    when start_on_2..end_on_2
      Schedule.seed do |s|
        s.task_id = 1 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end

    # 3章
    when start_on_3..end_on_3
      Schedule.seed do |s|
        s.task_id = 2 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end

    # 4章
    when start_on_4..end_on_4
      Schedule.seed do |s|
        s.task_id = 3 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end

    # 5章
    when start_on_5..end_on_5
      Schedule.seed do |s|
        s.task_id = 4 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end

    # 1章
    when start_on_1..end_on_1
      Schedule.seed do |s|
        s.task_id = 5 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end

    # 抄録
    when start_on_s..end_on_s
      Schedule.seed do |s|
        s.task_id = 6 + ((u.id  - 1) * 5)
        s.date = Date.yesterday
        s.time = [
          {"21:00" => "23:00"},
        ]
      end
    end
  end
end
