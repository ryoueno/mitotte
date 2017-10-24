class Api::V1::ActivitiesController < ApplicationController
  def create
    if activity_params[:user_id].present? and activity_params[:behavior].present?
      render json: Activity::create({
          user_id: activity_params[:user_id],
          behavior: Behavior::find_by(name: activity_params[:behavior]),
          target_id: activity_params[:task_id],
          created_at: activity_params[:created_at],
        })
    else
      logger.debug("Invalid param to create activity.")
      logger.debug(activity_params.inspect)
      render json: {'Error' => true}
    end
  end

  private

  def activity_params
    params.permit(:user_id, :behavior, :task_id, :created_at)
  end
end
