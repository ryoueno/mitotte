class Activity < ApplicationRecord
  belongs_to :user
  before_save :update_behavior

  def update_behavior
    data = process(read_attribute(:behavior))
    write_attribute(:behavior, data)
  end

  def process(behavior)
    behavior
  end

end
