class Task < ApplicationRecord
  belongs_to :project
  has_many :schedules
end
