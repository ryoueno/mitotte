class Project < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 200 }
end
