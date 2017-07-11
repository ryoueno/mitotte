class ActivityController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @project = Project.find(params[:project_id])
    @user = @project.user
    @the_day = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @activities = @user.activities.aggregate @the_day
    view_context.create(@activities,@the_day,@project)
    render 'guest' and return if params[:keyword] == @user.keyword
    render 'auth' if (not current_user) || @user.id != current_user.id
  end
end
