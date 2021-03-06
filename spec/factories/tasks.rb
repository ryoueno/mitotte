FactoryGirl.define do
  factory :task do
    subject { generate :task_subject }
    description { generate :task_description }
    after(:build) do |task|
      task.schedules << FactoryGirl.create(:schedule)
      task.schedules << FactoryGirl.create(:schedule)
    end
  end
end
