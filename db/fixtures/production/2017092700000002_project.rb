# 卒論プロジェクト

users = User.all

users.each do |u|
  Project.seed do |s|
    s.id = u.id # 卒研プロジェクトID = ユーザID
    s.user_id = u.id
    s.subject = "卒業論文執筆"
    s.description = "卒業論文を書いて、みんなで卒業しましょう。"
    s.start_on = Date.new(2017, 10, 31) # 2017.10.31 から
    s.end_on = Date.new(2017, 12, 10) # 2017.12.10 まで
  end
end
