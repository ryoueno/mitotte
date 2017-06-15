class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @schedules = Schedule.where(:date => Date.today)
  end
end
