Behavior.seed do |s|
  s.name = 'RESTING'
  s.display = '休憩'
  s.color_code = 'f9fbe7'
  s.priority = 1
end
Behavior.seed do |s|
  s.name = 'WORKING'
  s.display = '作業中'
  s.color_code = 'eeff41'
  s.priority = 10
end
Behavior.seed do |s|
  s.name = 'MOVING'
  s.display = '動作中'
  s.color_code = 'eeff41'
  s.priority = 12
end
Behavior.seed do |s|
  s.name = 'LAZY'
  s.display = 'さぼり？'
  s.color_code = '3e2723'
  s.priority = 6
end
Behavior.seed do |s|
  s.name = 'RUNNING'
  s.display = '動作中'
  s.color_code = 'eeff41'
  s.priority = 5
end
Behavior.seed do |s|
  s.name = 'CHANGE_STATUS'
  s.display = 'ステータス変更'
  s.color_code = 'eeff41'
  s.priority = 3
end
Behavior.seed do |s|
  s.name = 'CHANGE_SCHEDULE'
  s.display = '予定変更'
  s.color_code = 'eeff41'
  s.priority = 4
end
Behavior.seed do |s|
  s.name = 'DO_SOMETHING'
  s.display = '不明な状態'
  s.color_code = 'f4ff81'
  s.priority = 15
end
