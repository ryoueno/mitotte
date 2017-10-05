FactoryGirl.define do
  factory :activity do
    user

    # behavior: RESTING
    trait :resting do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :resting)
      end
    end

    # behavior: WORKING
    trait :working do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :working)
      end
    end

    # behavior: MOVING
    trait :moving do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :moving)
      end
    end

    # behavior: LAZY
    trait :lazy do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :lazy)
      end
    end

    # behavior: RUNNING
    trait :running do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :running)
      end
    end

    # behavior: CHANGE_STAUTS
    trait :change_status_1_to_2 do
      target_id 1
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :change_status)
      end
      update_from 1
      update_to 2
    end
    trait :change_status_2_to_3 do
      target_id 1
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :change_status)
      end
      update_from 2
      update_to 3
    end
    trait :change_status_3_to_4 do
      target_id 1
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :change_status)
      end
      update_from 3
      update_to 4
    end
    trait :change_status_4_to_5 do
      target_id 1
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :change_status)
      end
      update_from 4
      update_to 5
    end
    trait :change_status_5_to_1 do
      target_id 1
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :change_status)
      end
      update_from 5
      update_to 1
    end

    # behavior: DO_SOMETHING
    trait :do_something do
      after(:build) do |activity|
        activity.behavior = FactoryGirl.create(:behavior, :do_something)
      end
    end
  end
end
