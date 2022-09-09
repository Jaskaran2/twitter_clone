require "rails_helper"

RSpec.feature "Notifications",type: :feature do
    let(:user1){create(:user)}
    let(:user2){create(:user)}

    # before do
    #     sign_in(user1)
    #     create_tweet_signout_current_signin_another(user2)
    # end

    # scenario "receive like notification" do
    #     visit('/')
    #     expect(page).to have_content "Test tweet" 
    #     find(:css, '.fa-heart').click
        
    #     binding.pry
        
    # end

    before do
        sign_in(user1)
        visit('/')
        expect(page).to have_content 'Home'
        fill_in 'tweet_body',with:"Test tweet"       
        click_button 'Tweet'
        expect(page).to have_content "Test tweet"  
    end

    scenario "Receives like notification" do
        user2.like(Tweet.last)
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "#{user2.username} liked on your post"
    end

    scenario "Receives follow notification" do
        user2.follow(user1)
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "#{user2.username} started following you"
    end

    scenario "Receive retweet notification" do
        user2.tweets.create(parent_tweet_id: Tweet.last.id,tweet_type: "retweet" )
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "#{user2.username} retweeted your post"
    end

    scenario "Receive retweet notification" do
        user2.tweets.create(parent_tweet_id: Tweet.last.id,tweet_type: "retweet" )
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "#{user2.username} retweeted your post"
    end

    scenario "Receive reply notification" do
        user2.tweets.create(parent_tweet_id: Tweet.last.id,tweet_type: "reply",body: "Its a reply" )
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "#{user2.username} replied to your post"
    end

    scenario "Delete like notification on unlike" do
        expect{user2.like(Tweet.last)}.to change{Notification.count}.by(1)
        user2.unlike(Tweet.last)
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "You have no new notifications"
    end

    scenario "Delete follow notification on unfollowing" do
        expect{user2.follow(user1)}.to change{Notification.count}.by(1)
        user2.unfollow(user1)
        find(:css, '.sidebarOption_notification').click
        expect(page).to have_content "You have no new notifications"
    end
end