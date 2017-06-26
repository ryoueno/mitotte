class Screenshot < ApplicationRecord
  has_many :detections

  def name
    self.src + "." + self.extension
  end

  def path
    Rails.root.to_s + "/public/images/screenshots/" + self.name
  end

  # 5分前 ~ 1秒前 のスクリーンショットを1件取得
  def recent
    Screenshot.where(created_at: (self.created_at - 5.minute)..(self.created_at - 1.second)).order("created_at desc").first
  end
end
