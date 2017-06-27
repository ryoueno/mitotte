class Activity < ApplicationRecord
  belongs_to :user
  before_save :update_behavior

  @@second_per_group = 600

  scope :aggregate, -> date {
    rows = find_by_sql(["SELECT count(*), MIN(behavior) as behavior, tasks.subject as subject, activities.created_at FROM activities LEFT JOIN tasks ON task_id = tasks.id where DATE(activities.created_at) = ? GROUP BY TRUNCATE(UNIX_TIMESTAMP(activities.created_at) / ?, 0)", date, @@second_per_group])
  }

  def update_behavior
    data = process(read_attribute(:behavior))
    write_attribute(:behavior, data)
  end

  def behavior_jp
    case
    when self.behavior.include?("RESTING")
      "休憩"
    when self.behavior.include?("WORKING")
      "作業中"
    when self.behavior.include?("MOVING")
      "さぼり？"
    when self.behavior.include?("RUNNING")
      "動作中"
    when self.behavior.include?("DO_SOMETHING")
      "不明な状態"
    else
      self.behavior
    end
  end

  def process(behavior)
    behavior
  end

end
