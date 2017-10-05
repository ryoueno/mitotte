# 10日前から10日後までのプロジェクト
Project.seed do |s|
  s.id = 1
  s.user_id = 1
  s.subject = "プロジェクト-ID:1"
  s.description = "10日前から10日後までのプロジェクト"
  s.start_on = 10.days.ago
  s.end_on = 10.days.since
end

# 10日前から今日までのプロジェクト
Project.seed do |s|
  s.id = 2
  s.user_id = 1
  s.subject = "プロジェクト-ID:2"
  s.description = "10日前から今日までのプロジェクト"
  s.start_on = 10.days.ago
  s.end_on = Date.today
end

# 今日から10日後までのプロジェクト
Project.seed do |s|
  s.id = 3
  s.user_id = 1
  s.subject = "プロジェクト-ID:3"
  s.description = "今日から10日後までのプロジェクト"
  s.start_on = Date.today
  s.end_on = 10.days.since
end

# 明日から10日後までのプロジェクト
Project.seed do |s|
  s.id = 4
  s.user_id = 1
  s.subject = "プロジェクト-ID:4"
  s.description = "明日から10日後までのプロジェクト"
  s.start_on = Date.today
  s.end_on = 10.days.since
end

# 10日前から昨日までのプロジェクト
Project.seed do |s|
  s.id = 5
  s.user_id = 1
  s.subject = "プロジェクト-ID:5"
  s.description = "10日前から昨日までのプロジェクト"
  s.start_on = 10.days.ago
  s.end_on = Date.yesterday
end
