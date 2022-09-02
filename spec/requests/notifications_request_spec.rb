require "rails_helper"

RSpec.describe "Notifications" do
  

    before(:context){ post '/users',:params => {:user => {:name=>"Test",:username =>"test123", :email=> "test121@gmail.com",:password=>"123456",:password_confirmation=>"123456" } }}
    let!(:initial_notification_count){ Notification.count}
    
    context "create notifications" do
      
        it "creates retweet notification" do
            tweet=create(:tweet)
            post "/tweets/#{tweet.id}/retweet",:params => { :body=> nil, :parent_tweet_id=> tweet.id}, as: :turbo_stream 
            expect(Notification.count).to eq( initial_notification_count+1)  
            expect(Notification.last.action).to eq("retweet")  
        end

        it "creates reply notification" do
            tweet=create(:tweet)
            post "/tweets/#{tweet.id}/reply",:params => { :body=> "Its a reply", :parent_tweet_id=> tweet.id}, as: :turbo_stream 
            expect(Notification.count).to eq( initial_notification_count+1)  
            expect(Notification.last.action).to eq("reply")  
        end

        it "create like notification" do
            tweet=create(:tweet)
            post "/like/#{tweet.id}"
            expect(Notification.count).to eq( initial_notification_count+1) 
            expect(Notification.last.action).to eq("like")  
        end

        it "create follow notification" do
            user2=create(:user)
            post "/profiles/#{user2.id}/friendships"
            expect(Notification.count).to eq( initial_notification_count+1)  
            expect(Notification.last.action).to eq("followed")  
        end

    end

    context "delete notification" do
        it "deletes like notification on unlike" do
            tweet=create(:tweet)
            post "/like/#{tweet.id}"
            post "/like/#{tweet.id}"
            expect(Notification.count).to eq( initial_notification_count ) 
        end

        it "deletes follow notification on unfollow" do
            user2=create(:user)
            post "/profiles/#{user2.id}/friendships"
            delete "/profiles/#{user2.id}/friendships/#{user2.id}"         
            expect(Notification.count).to eq( initial_notification_count )
        end
    end

end