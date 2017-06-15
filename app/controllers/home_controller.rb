class HomeController < ApplicationController
  before_action :authenticate_user!
  def index

    gon.config = {'databaseURL' => ENV['GOOGLE_FIREBASE_URL']}
    gon.key = "activity/#{current_user.uuid}/"
    @schedules = Schedule.where(:date => Date.today)
  end
end
