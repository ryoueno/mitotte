FactoryGirl.define do
  factory :project do
    user
    subject { generate :subject }
    description { generate :description }
    start_at { generate :start_at }
    end_at { generate :end_at }
  end
end
