class ActivityController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    return if params[:keyword] == User.find(params[:user_id]).keyword
    render 'auth' if not @current_id or params[:user_id] != @current_user.id
  end
end
