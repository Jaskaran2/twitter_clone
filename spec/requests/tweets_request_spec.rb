require "rails_helper"

RSpec.describe "Creating articles" do
  
    context "Creating tweet" do
        
        before{ post '/users',params: {user: {name: "Test",username: "test123", email: "test121@gmail.com",password: "123456",password_confirmation: "123456" } }}
        let!(:tweet){create(:tweet,user: User.last)}

        it "has type tweet" do
            expect{post '/tweets', params: { tweet: { body: "Test"} }, as: :turbo_stream }.to change{Tweet.count}.by(1)  
            expect(Tweet.last.tweet_type).to eq("tweet")
        end

        it "has type retweet" do                 
            expect{  post "/tweets/#{tweet.id}/retweet",params: { body: nil, parent_tweet_id: tweet.id}, as: :turbo_stream }.to change{Tweet.count}.by(1)  
            expect(Tweet.last.tweet_type).to eq("retweet")            
        end


        it "has type reply" do
            expect{ post "/tweets/#{tweet.id}/reply",params: { body: "Its a reply", parent_tweet_id: tweet.id}, as: :turbo_stream }.to change{Tweet.count}.by(1)         
            expect(Tweet.last.tweet_type).to eq("reply")     
        end
    end
end