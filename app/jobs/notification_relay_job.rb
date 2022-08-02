class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    puts "hi I got called##################################"
    html= ApplicationController.render partial:"notifications/notification",locals:{notifications: [notification]},format: [:html]
    puts "hi I got called after html##################################"
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", {html: html}
  end
end
