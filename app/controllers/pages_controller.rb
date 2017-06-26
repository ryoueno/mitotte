class PagesController < ApplicationController
  def index
  end

  def diff
    @image_differences = ImageDifference.all
    @image_path = "/images/screenshots/test/"
  end
end
