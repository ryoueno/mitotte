FactoryGirl.define do
  factory :screenshot do
    uuid { generate :uuid }
    extension { generate :extension }
  end
end
