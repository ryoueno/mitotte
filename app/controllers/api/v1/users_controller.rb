class Api::V1::UsersController < ApplicationController
  def index
    if user_params[:name].present?
      render json: User.where("name = ?", user_params[:name])
    else
      render json: User.all
    end
  end

  private

  def user_params
    params.permit(:name)
  end
end
