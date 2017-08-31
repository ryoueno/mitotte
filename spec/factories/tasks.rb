FactoryGirl.define do
  factory :task do
    project
    subject { generate :task_subject }
    description { generate :task_description }
    status { generate :task_status }
    after(:build) do |task|
      task.schedules << FactoryGirl.create(:schedule)
      task.schedules << FactoryGirl.create(:schedule)
    end
  end
end
