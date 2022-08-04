class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html= ApplicationController.render partial:"notifications/notification",locals:{notifications: [notification]},format: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", {html: html}
  end
end
