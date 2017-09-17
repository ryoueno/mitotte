class ActivityController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  require 'gruff'
  def index
    @project = Project.find(params[:project_id])
    @user = @project.user
    @the_day = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @activities = @user.activities.aggregate @the_day

    # 進捗グラフ作成
    view_context.generate_progress_graph

    # アクティビティテーブル作成
    view_context.generate_activity_table(@activities, @the_day, @project)

    render 'guest' and return if params[:keyword] == @user.keyword
    render 'auth' if (not current_user) || @user.id != current_user.id
  end
end
