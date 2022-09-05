FactoryBot.define do
    factory :tweet do
        body {"It is a normal tweet"}
        tweet_type {"tweet"}
        parent_tweet_id {nil}
        user_id {nil}
        association :user


        # trait :retweet do
        #     tweet_type {"retweet"}
        # end       
        
        # trait :reply do
        #     body {"It is a reply on a tweet"}
        #     tweet_type {"reply"}
        # end 
        
        # factory :retweet_type, traits: [:retweet] 
        # factory :reply_type, traits: [:reply] 

    end
end