User.seed do |s|
  s.id = 1
  s.name = "テストユーザ"
  s.email = "test@mitotte.com"
  s.uuid = Faker::Code.unique.asin
  s.password = "secret"
end
