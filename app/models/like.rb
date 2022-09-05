class Like < ApplicationRecord
  include NotificationHelper

  belongs_to :user
  belongs_to :tweet

  after_create_commit :send_like_notification

  after_destroy_commit :delete_like_notification

  def send_like_notification
    notification=Notification.create(recipient: self.tweet.user,actor: self.user,action: "like",notifiable: self.tweet)
    NotificationRelayJob.perform_later(notification)
    notify(notification)
  end

  def delete_like_notification
    Notification.where(action:"like")
                .where(notifiable_id: self.tweet.id)
                .where(actor: Current.user).delete_all
  end
  
end
