class NotificationMailer < ApplicationMailer
  def task_notification(user, task)
    @user = user
    @task = task
    mail(to: @user.email, subject: 'Task Notification')
  end
end
