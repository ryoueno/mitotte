class Screenshot < ApplicationRecord
  has_many :detections

  def name
    self.src + "." + self.extension
  end

  def path
    Rails.root.to_s + "/public/images/screenshots/" + self.name
  end
end
