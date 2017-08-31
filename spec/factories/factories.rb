FactoryGirl.define do
  sequence(:name) { Faker::Name.name }
  sequence(:email) { Faker::Internet.email }
  sequence(:uuid) { Faker::Code.unique.asin }
  sequence(:password) { "secret" }
end
