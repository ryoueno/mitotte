class Activity < ApplicationRecord
  belongs_to :user
  before_save :update_behavior

  @@second_per_group = 600
  COLOR_RESTIMG = "#f9fbe7"
  COLOR_WORKING = "#eeff41"
  COLOR_MOVING = "#b71c1c"
  COLOR_RUNNING = "#f4ff81"
  COLOR_DO_SOMETHING = "#f4ff81"
  COLOR_DEFAULT = "#f6f6ff"

  scope :aggregate, -> date {
    rows = find_by_sql(["SELECT count(*), MIN(behavior) as behavior, tasks.subject as subject, activities.created_at FROM activities LEFT JOIN tasks ON task_id = tasks.id where DATE(activities.created_at) = ? GROUP BY TRUNCATE(UNIX_TIMESTAMP(activities.created_at) / ?, 0)", date, @@second_per_group])
    activities = {}
    (0..23).each do |hour|
      0.step(50, 10) do |minute|
        activities[sprintf("%02d:%02d", hour, minute)] = nil
      end
    end
    rows.each do |row|
      # 28分 -> 20分
      minute = (row.created_at.min.to_f / 10).floor * 10
      activities[row.created_at.change(min: minute).strftime("%H:%M")] = row
    end
    return activities
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

  def behavior_color
    case
    when self.behavior.include?("RESTING")
      COLOR_RESTIMG
    when self.behavior.include?("WORKING")
      COLOR_WORKING
    when self.behavior.include?("MOVING")
      COLOR_MOVING
    when self.behavior.include?("RUNNING")
      COLOR_RUNNING
    when self.behavior.include?("DO_SOMETHING")
      COLOR_DO_SOMETHING
    else
      COLOR_DEFAULT
    end
  end

  def process(behavior)
    behavior
  end

end
