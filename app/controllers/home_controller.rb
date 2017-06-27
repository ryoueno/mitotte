class HomeController < ApplicationController
  before_action :authenticate_user!
  def index

    gon.config = {'databaseURL' => ENV['GOOGLE_FIREBASE_URL']}
    gon.key = "activity/#{current_user.uuid}/"
    gon.user_id = current_user.id
    gon.activity_api_url = api_v1_activities_path
    @schedules = Schedule.todays_users_schedules current_user.id
  end
end
