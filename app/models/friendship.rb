class Friendship < ApplicationRecord
    include NotificationHelper
    belongs_to :follower,class_name:"User"
    belongs_to :followed,class_name:"User"

    validates :follower_id,presence: true
    validates :followed_id,presence: true

    after_destroy_commit :send_unfollow_notification

    after_create_commit :send_follow_notification


    def send_unfollow_notification
        recipient_id=self.followed_id
        notification=Notification.create(recipient: User.find(recipient_id),actor:Current.user,action: "unfollowed",notifiable: User.find(recipient_id))
        NotificationRelayJob.perform_later(notification)

        notify(notification)
    end

    def send_follow_notification
        recipient_id=self.followed_id
        notification=Notification.create(recipient: User.find(recipient_id),actor:Current.user,action: "followed",notifiable: User.find(recipient_id))
        NotificationRelayJob.perform_later(notification)

        notify(notification)
    end
    
end
