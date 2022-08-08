class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    Turbo::StreamsChannel.broadcast_prepend_later_to "notification_page",
    target:"notification_page_#{notification.recipient.id}",
    partial:"notifications/notification",
    locals: {notifications: [notification],user_id: notification.recipient.id}
  end

end
