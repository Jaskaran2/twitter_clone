require "rails_helper"

RSpec.describe "Creating articles" do
  
    context "Creating tweet" do
        before{ post '/users',:params => {:user => {:name=>"Test",:username =>"test123", :email=> "test121@gmail.com",:password=>"123456",:password_confirmation=>"123456" } }}
        let!(:tweet){create(:tweet)}

        it "type tweet" do
            number_of_tweets=Tweet.count
            post '/tweets',:params => { :tweet => { :body=> "Test"} }, as: :turbo_stream
            expect(Tweet.last.tweet_type).to eq("tweet")
            expect(Tweet.count).to eq(number_of_tweets+1)
        end

        it "type retweet" do
            number_of_tweets=Tweet.count
            post "/tweets/#{tweet.id}/retweet",:params => { :body=> nil, :parent_tweet_id=> tweet.id}, as: :turbo_stream 
            expect(Tweet.last.tweet_type).to eq("retweet") 
            expect(Tweet.count).to eq(number_of_tweets+1)
        end


        it "type reply" do
            number_of_tweets=Tweet.count
            post "/tweets/#{tweet.id}/reply",:params => { :body=> "Its a reply", :parent_tweet_id=> tweet.id}, as: :turbo_stream 
            expect(Tweet.last.tweet_type).to eq("reply") 
            expect(Tweet.count).to eq(number_of_tweets+1)
        end
    end
end