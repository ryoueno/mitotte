class Schedule < ApplicationRecord
  belongs_to :task
  scope :todays_users_schedules, -> user_id {
    joins({:task => :project}).where("projects.user_id" => user_id, :date => Date.today)
  }
end
