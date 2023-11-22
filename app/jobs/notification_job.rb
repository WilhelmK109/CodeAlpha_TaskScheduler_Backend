class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_id)
    notification = Notification.find(notification_id)
    # Add logic here to send the notification (email or push notification)
  end
end
