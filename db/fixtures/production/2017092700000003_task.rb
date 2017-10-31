# 全員にタスク割り当て
users = User.all

users.each do |u|
  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文2章執筆"
    s.description = "論文の2章を執筆する"
  end

  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文3章執筆"
    s.description = "論文の3章を執筆する"
  end

  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文4章執筆"
    s.description = "論文の4章を執筆する"
  end

  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文5章執筆"
    s.description = "論文の5章を執筆する"
  end

  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文1章執筆"
    s.description = "論文の1章を執筆する"
  end


  Task.seed do |s|
    s.project_id = u.id
    s.subject = "論文抄録執筆"
    s.description = "論文の抄録を執筆する"
  end
end
