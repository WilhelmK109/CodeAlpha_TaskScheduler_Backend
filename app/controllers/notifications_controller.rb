class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = current_user.tasks.find(params[:task_id])
    @notification = @task.notifications.build(notification_params)

    if @notification.save
      # Enqueue the job to send the notification
      NotificationJob.perform_later(@notification.id)
      render json: @notification
    else
      render json: { errors: @notification.errors.full_message }, status: :unprocessable_entity
    end
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    head :no-content
  end

  private

  def notification_params
    params.require(:notification).permit(:scheduled_at)
  end
end