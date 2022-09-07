require "rails_helper"

RSpec.feature "Impressions",type: :feature do

    let(:user1){create(:user)}

    before do
        sign_in(user1)
    end

    feature "current user visit" do
        
        before do
            visit('/')
            expect(page).to have_content 'Home'
            fill_in 'tweet_body',with:"Test tweet"       
            click_button 'Tweet'
        end

        scenario "count does not increase" do   
            expect(page).to have_content "Test tweet" 
            find(:css, '.fa-comment').click
            visit("/tweets/#{Tweet.last.id}")
            expect(page).to have_content "0 users have seen your post"  
        end

    end

    feature "other user visits the post" do
        
        let(:user2){create(:user)}
        
        before do
            visit('/')
            expect(page).to have_content 'Home'
            fill_in 'tweet_body',with:"Test tweet"       
            click_button 'Tweet'
            find(:css, '.logout_button').click
        end

        before do
            user2.follow(user1)
            sign_in(user2)
        end

        scenario "count increases" do   
            expect(page).to have_content "Test tweet"
            find(:css, '.fa-comment').click   
            visit("/tweets/#{Tweet.last.id}")
            expect(page).to have_content "1 user have seen this post"  
        end

        scenario "count does not increase on revisit" do
            expect(page).to have_content "Test tweet"
            find(:css, '.fa-comment').click   
            visit("/tweets/#{Tweet.last.id}")
            expect(page).to have_content "1 user have seen this post" 
            visit("/")
            find(:css, '.fa-comment').click   
            visit("/tweets/#{Tweet.last.id}")
            expect(page).to have_content "1 user have seen this post"
        end
    end
end