class Task < ApplicationRecord
  belongs_to :project
  has_many :schedules

  def status
    TaskStatus.new self.status_before_type_cast
  end
end
