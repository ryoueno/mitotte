# 5種類のプロジェクト全てにタスクを生成
5.times do |i|
  Task.seed do |s|
    id = (i * 5) + 1
    s.id = id
    s.project_id = i + 1
    s.subject = "タスク-ID:#{id}"
    s.description = "タスク-ID:#{id}-project_id:#{i + 1}"
  end

  Task.seed do |s|
    id = (i * 5) + 2
    s.id = id
    s.project_id = i + 1
    s.subject = "タスク-ID:#{id}"
    s.description = "タスク-ID:#{id}-project_id:#{i + 1}"
  end

  Task.seed do |s|
    id = (i * 5) + 3
    s.id = id
    s.project_id = i + 1
    s.subject = "タスク-ID:#{id}"
    s.description = "タスク-ID:#{id}-project_id:#{i + 1}"
  end

  Task.seed do |s|
    id = (i * 5) + 4
    s.id = id
    s.project_id = i + 1
    s.subject = "タスク-ID:#{id}"
    s.description = "タスク-ID:#{id}-project_id:#{i + 1}"
  end

  Task.seed do |s|
    id = (i * 5) + 5
    s.id = id
    s.project_id = i + 1
    s.subject = "タスク-ID:#{id}"
    s.description = "タスク-ID:#{id}-project_id:#{i + 1}"
  end
end
