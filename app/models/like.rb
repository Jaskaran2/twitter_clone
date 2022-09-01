class Like < ApplicationRecord
  include NotificationHelper

  belongs_to :user
  belongs_to :tweet

  after_create_commit :send_like_notification

  after_destroy_commit :send_unlike_notification

  def send_like_notification
    notification=Notification.create(recipient: self.tweet.user,actor: Current.user,action: "like",notifiable: self.tweet)
    NotificationRelayJob.perform_later(notification)
    notify(notification)
  end

  def send_unlike_notification
    notification=Notification.create(recipient: self.tweet.user,actor: Current.user,action: "unlike",notifiable: self.tweet)
    NotificationRelayJob.perform_later(notification)
    notify(notification)
  end
  
end
