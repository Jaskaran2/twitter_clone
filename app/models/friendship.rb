class Friendship < ApplicationRecord
    include NotificationHelper
    belongs_to :follower,class_name:"User"
    belongs_to :followed,class_name:"User"

    validates :follower_id,presence: true
    validates :followed_id,presence: true

    after_destroy_commit :send_unfollow_notification

    after_create_commit :send_follow_notification


    def send_unfollow_notification
        notification=Notification.create(recipient: self.followed,actor: self.follower,action: "unfollowed",notifiable: self.followed)
        NotificationRelayJob.perform_later(notification)
        notify(notification)
    end

    def send_follow_notification
        notification=Notification.create(recipient: self.followed,actor: self.follower,action: "followed",notifiable: self.followed)
        NotificationRelayJob.perform_later(notification)
        notify(notification)
    end
    
end
