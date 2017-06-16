class Api::V1::ActivitiesController < ApplicationController
  def create
    if activity_params[:user_id].present? and activity_params[:behavior].present?
      render json: Activity::create(activity_params)
    else
      logger.debug("Invalid param to create activity.")
      logger.debug(activity_params.inspect)
      render json: {'Error' => true}
    end
  end

  private

  def activity_params
    params.permit(:user_id, :behavior, :created_at)
  end
end
