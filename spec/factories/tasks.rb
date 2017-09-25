FactoryGirl.define do
  factory :task do
    subject { generate :task_subject }
    description { generate :task_description }
    task_status_id { generate :task_status_id }
    after(:build) do |task|
      task.schedules << FactoryGirl.create(:schedule)
      task.schedules << FactoryGirl.create(:schedule)
    end
  end
end
