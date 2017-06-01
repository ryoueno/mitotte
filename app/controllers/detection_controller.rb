class DetectionController < ApplicationController
  def index
    @screenshots = Screenshot.order("id DESC").all
  end
end
