FactoryGirl.define do
  factory :activity do
    trait :update_task do
      user_id 1
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
    trait :do_something do
      name 'DO_SOMETHING'
      display '不明な状態'
      color_code 'f4ff81'
      priority 6
    end
  end
end
