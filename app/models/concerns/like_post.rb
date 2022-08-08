module LikePost
    extend ActiveSupport::Concern

    def liked?(tweet)
      liked_tweets.include?(tweet)
    end
  
    def liked_comment?(comment)
      liked_comments.include?(comment)
    end
  
    def like(tweet)
      if liked_tweets.include?(tweet)
        liked_tweets.destroy(tweet)
          #create unlike notification
          notification=Notification.create(recipient:tweet.user,actor:Current.user,action:"unlike",notifiable:tweet)
          NotificationRelayJob.perform_later(notification)
      else
        liked_tweets<<tweet
          #create like notification
          notification=Notification.create(recipient:tweet.user,actor:Current.user,action:"like",notifiable:tweet)
          NotificationRelayJob.perform_later(notification)
      end 
      
      notify(notification)
      public_target="tweet_#{tweet.id}_public_likes"
      broadcast_replace_later_to "public_likes",
                                  target:public_target,
                                  partial:"likes/like_count",
                                  locals:{tweet:tweet}
    end
  
  
    def like_comment(comment)
      if liked_comments.include?(comment)
        liked_comments.destroy(comment)

        notification=Notification.create(recipient:comment.user,actor:Current.user,action:"unliked comment",notifiable:comment)
        NotificationRelayJob.perform_later(notification)
      else
        liked_comments<<comment

        notification=Notification.create(recipient:comment.user,actor:Current.user,action:"liked comment",notifiable:comment)
        NotificationRelayJob.perform_later(notification)
      end

        notify(notification)
    end

  end