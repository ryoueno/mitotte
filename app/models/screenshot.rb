class Screenshot < ApplicationRecord
  has_many :detections

  # 類似画像を探す範囲(分)
  TIME_TO_TRACE = 5

  # 同じ画像とみなす画像の類似度
  MEAN_ERROR_PER_PIXEL = 5000

  def name
    self.src + "." + self.extension
  end

  def path
    Rails.root.to_s + "/public/images/screenshots/" + self.name
  end

  # 5分前 ~ 1秒前 のスクリーンショットを1件取得
  def recent
    Screenshot.where(created_at: (self.created_at - TIME_TO_TRACE.minute)..(self.created_at - 1.second)).order("created_at desc").first
  end

  def error_per_pixel
    if self.recent
      img1 = Magick::Image.read(Rails.root.join(App::Application.config.screenshots_path, self.name)).first
      img2 = Magick::Image.read(Rails.root.join(App::Application.config.screenshots_path, self.recent.name)).first
      return img1.difference(img2)[0]
    end
    false
  end

  def similar?
    self.error_per_pixel && self.error_per_pixel < MEAN_ERROR_PER_PIXEL
  end
end
