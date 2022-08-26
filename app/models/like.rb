class Like < ApplicationRecord
  include NotificationHelper

  belongs_to :likeable, polymorphic: true
  belongs_to :user

  after_create_commit :send_like_notification

  after_destroy_commit :send_unlike_ntification

  def send_like_notification
    liked_tweet_id=self.likeable_id
    notification=Notification.create(recipient: Tweet.find_by(id:liked_tweet_id).user,actor:Current.user,action: "like",notifiable: Tweet.find_by(id:liked_tweet_id))
    NotificationRelayJob.perform_later(notification)

    notify(notification)
  end

  def send_unlike_ntification
    liked_tweet_id=self.likeable_id
    notification=Notification.create(recipient: Tweet.find_by(id:liked_tweet_id).user,actor:Current.user,action: "unlike",notifiable: Tweet.find_by(id:liked_tweet_id))
    NotificationRelayJob.perform_later(notification)

    notify(notification)
  end
  
end
