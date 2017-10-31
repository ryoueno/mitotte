User.seed do |s|
  s.name = "上野 涼"
  s.email = "a8114035@aoyama.jp"
  s.uuid = Faker::Code.unique.asin
  s.slack_name = "uenoryo"
  s.password = "secret"
end

User.seed do |s|
  s.name = "上田 凛太郎"
  s.email = "a8114033@aoyama.jp"
  s.uuid = Faker::Code.unique.asin
  s.slack_name = "uenoryo"
  s.password = "secret"
end
