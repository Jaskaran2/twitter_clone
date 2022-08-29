FactoryBot.define do
    factory :tweet do
        body {"It is a normal tweet"}
        user_id {1}
        retweet_id {nil}
        reply_id {nil}
        tweet_type {"tweet"}
        association :user
        
        trait :retweet do
            body {nil}
            user_id {1}
            retweet_id {1}
            tweet_type {"retweet"}
        end       
        
        trait :reply do
            body {"It is a reply on a tweet"}
            user_id {1}
            reply_id {1}
            tweet_type {"reply"}
        end 
        
        factory :retweet_type, traits: [:retweet] 
        factory :reply_type, traits: [:reply] 

    end
end