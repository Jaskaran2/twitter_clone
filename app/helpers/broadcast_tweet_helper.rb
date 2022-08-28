module BroadcastTweetHelper
   
    def broadcastTweet(tweet)
        Turbo::StreamsChannel.broadcast_prepend_later_to "public_tweets",
        target:"tweets",
        partial:"tweets/tweet",
        locals: {tweet:tweet}
    end

    def broadcastRetweet(retweet)         
        Turbo::StreamsChannel.broadcast_prepend_later_to "public_tweets",
        target:"tweets",
        partial:"tweets/retweet",
        locals: {tweet:retweet}
    end
    
end