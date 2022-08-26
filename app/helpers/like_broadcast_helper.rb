module LikeBroadcastHelper
    def like_broadcast(tweet)
        public_target="tweet_#{tweet.id}_public_likes"
        broadcast_replace_later_to "public_likes",
                                    target:public_target,
                                    partial:"likes/like_count",
                                    locals:{tweet:tweet}
    end
end