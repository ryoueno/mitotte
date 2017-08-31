FactoryGirl.define do
  sequence(:name) { Faker::Name.name }
  sequence(:email) { Faker::Internet.email }
  sequence(:uuid) { Faker::Code.unique.asin }
  sequence(:password) { "secret" }
  sequence(:subject) { Faker::Pokemon.unique.location + "プロジェクト" }
  sequence(:description) { Faker::Pokemon.unique.location + "で活躍するために必要なスキルを身につけるためのプロジェクトです。" }
  sequence(:start_at) { Date.today }
  sequence(:end_at) { 10.days.since }
  sequence(:task_subject) { Faker::Pokemon.name + "を捕まえる" }
  sequence(:task_description) { Faker::Pokemon.name + "を捕まえて、育成する" }
  sequence(:task_status) { TaskStatus::get.values.sample }
end
