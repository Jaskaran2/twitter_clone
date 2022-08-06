module FollowUser
    extend ActiveSupport::Concern


  def follow(user)
    active_friendships.create(followed_id: user.id)
    #create notification for follow
    notification=Notification.create(recipient:user,actor:Current.user,action:"followed",notifiable:user)
    NotificationRelayJob.perform_later(notification)

    notify(notification)

  end

  def unfollow(user)
    active_friendships.find_by(followed_id: user.id).destroy
      #create notification for unfollow
      notification=Notification.create(recipient:user,actor:Current.user,action:"unfollowed",notifiable:user)
      NotificationRelayJob.perform_later(notification)

      notify(notification)

  end

  def following?(user)
    following.include?(user)
  end

end