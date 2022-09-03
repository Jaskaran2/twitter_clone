require "rails_helper"

RSpec.describe "Notifications" do
  

    before{ post '/users',:params => {:user => {:name=>"Test",:username =>"test123", :email=> "test121@gmail.com",:password=>"123456",:password_confirmation=>"123456" } }}
    
    context "create notifications" do
      
        it "creates retweet notification" do
            tweet = create(:tweet)         
            expect{post "/tweets/#{tweet.id}/retweet",:params => { :body=> nil, :parent_tweet_id=> tweet.id}, as: :turbo_stream }.to change{Notification.count}.by(1)
            expect(Notification.last.action).to eq("retweet")  
        end

        it "creates reply notification" do
            tweet = create(:tweet)
            expect{ post "/tweets/#{tweet.id}/reply",:params => { :body=> "Its a reply", :parent_tweet_id=> tweet.id}, as: :turbo_stream }.to change{Notification.count}.by(1)
            expect(Notification.last.action).to eq("reply")  
        end

        it "create like notification" do
            tweet = create(:tweet)
            expect{ post "/like/#{tweet.id}" }.to change{Notification.count}.by(1) 
            expect(Notification.last.action).to eq("like")  
        end

        it "create follow notification" do
            user2 = create(:user)
            expect{ post "/profiles/#{user2.id}/friendships" }.to change{Notification.count}.by(1)  
            expect(Notification.last.action).to eq("followed")  
        end

    end

    context "delete notification" do
        it "deletes like notification on unlike" do
            tweet = create(:tweet)
            post "/like/#{tweet.id}"
            expect{ post "/like/#{tweet.id}" }.to change{Notification.count}.by(-1)  
        end

        it "deletes follow notification on unfollow" do
            user2 = create(:user)
            post "/profiles/#{user2.id}/friendships"
            expect{ delete "/profiles/#{user2.id}/friendships/#{user2.id}" }.to change{Notification.count}.by(-1)          
        end
    end
end