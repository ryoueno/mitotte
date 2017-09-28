User.seed do |s|
  s.name = "素晴らしい開発者"
  s.email = "r.r.ag0611@outlook.jp"
  s.uuid = Faker::Code.unique.asin
  s.password = "secret"
end

50.times do |i|
  User.seed do |s|
    s.name = Faker::Name.unique.name
    s.email = Faker::Internet.unique.email
    s.uuid = Faker::Code.unique.asin
    s.password = "secret"
  end
end
