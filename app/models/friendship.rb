class Friendship < ApplicationRecord
    include NotificationHelper
    belongs_to :follower,class_name:"User"
    belongs_to :followed,class_name:"User"

    validates :follower_id,presence: true
    validates :followed_id,presence: true

    after_destroy_commit :delete_follow_notification

    after_create_commit :send_follow_notification


    def delete_follow_notification
        Notification.where(action:"followed")
        .where(notifiable_id: self.followed.id)
        .where(actor: Current.user).delete_all
    end

    def send_follow_notification
        notification=Notification.create(recipient: self.followed,actor: self.follower,action: "followed",notifiable: self.followed)
        NotificationRelayJob.perform_later(notification)
        notify(notification)
    end
    
end
