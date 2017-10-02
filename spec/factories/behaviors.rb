FactoryGirl.define do
  factory :behavior do
    trait :resting do
      name 'RESTING'
      display '休憩'
      color_code 'f9fbe7'
      priority 1
    end
    trait :working do
      name 'WORKING'
      display '作業中'
      color_code 'eeff41'
      priority 2
    end
    trait :moving do
      name 'MOVING'
      display '動作中'
      color_code 'eeff41'
      priority 3
    end
    trait :lasy do
      name 'LAZY'
      display 'さぼり？'
      color_code '3e2723'
      priority 4
    end
    trait :running do
      name 'RUNNING'
      display '動作中'
      color_code 'f4ff81'
      priority 5
    end
    trait :change_status do
      name 'CHANGE_STATUS'
      display 'ステータス変更'
      color_code 'ccccff'
      priority 6
    end
    trait :do_something do
      name 'DO_SOMETHING'
      display '不明な状態'
      color_code 'f4ff81'
      priority 7
    end
  end
end
