FactoryGirl.define do
  factory :user do
    email { generate :email }
    name { generate :name }
    uuid { generate :uuid }
    password { generate :password }
  end
end
