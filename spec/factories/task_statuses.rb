FactoryGirl.define do
  factory :task_status do
    trait :initial do
      name 'INITIAL'
      display '初期'
    end
    trait :pending do
      name 'PENDING'
      display 'しぶい'
    end
    trait :progress do
      name 'PROGRESS'
      display '進行中'
    end
    trait :done do
      name 'DONE'
      display '完了'
    end
    trait :rejected do
      name 'REJECTED'
      display '却下'
    end
  end
end
