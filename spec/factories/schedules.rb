FactoryGirl.define do
  factory :schedule do
    task_id 1
    date Date.today
    time [
      {'08:00' => '10:00'},
      {'18:00' => '20:00'},
    ]
  end
end
