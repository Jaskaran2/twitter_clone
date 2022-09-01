require "rails_helper"

RSpec.feature "Create tweets", driver: :selenium_chrome, js: true,type: :feature do

    feature "User is signed in" do
        let(:user){create(:user)}

        before do
            visit "/users/sign_in"
            fill_in 'Email',with: user.email
            fill_in 'Password',with: user.password
            click_button 'Log in'
            expect(page).to have_content 'Signed in successfully'
        end

        before do
            visit('/')
            expect(page).to have_content 'Home'
            fill_in 'tweet_body',with:"Test tweet"      
            click_button 'Tweet' 
        end
        
        scenario "tweet gets created" do
            expect(page).to have_content "Test tweet"
        end


        scenario "Retweet gets created" do
            expect(page).to have_content "Test tweet"         
            click_button "retweet_#{Tweet.last.id}"
            expect(page).to have_content "Retweeted by @#{user.name}"
        
        end

        scenario "reply gets created" do
            expect(page).to have_content "Test tweet" 
            find(:css, '.fa-comment').click              
            visit("/tweets/#{Tweet.last.id}")
            fill_in 'body',with:"Its a reply"       
            click_button 'Reply'
            expect(page).to have_content "Replied by @#{user.name}"
         
        end

    end
end