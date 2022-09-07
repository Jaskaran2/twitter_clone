require "rails_helper"

RSpec.feature "delete tweets",type: :feature do
    let(:user){create(:user)}

    before do
        sign_in(user)
    end

    before do
        visit('/')
        expect(page).to have_content 'Home'
        fill_in 'tweet_body',with:"Test tweet"       
        click_button 'Tweet'
    end

    scenario "delete tweet" do
        expect(page).to have_content "Test tweet"
        expect{ find(:css, '.fa-trash').click }.to change{Tweet.count}.by(-1)
    end

    scenario "delete retweet" do
        expect(page).to have_content "Test tweet" 
        click_button "retweet_#{Tweet.last.id}"
        expect{ find(:css, "#delete_#{Tweet.first.id}").click }.to change{Tweet.count}.by(-2)
    end

    scenario "delete reply" do
        
        binding.pry
        
        expect(page).to have_content "Test tweet"  
        find(:css, '.fa-comment').click        
        visit("/tweets/#{Tweet.last.id}")
        fill_in 'body',with:"Its a reply"       
        click_button 'Reply'
        visit("/")
        expect{ find(:css, "#delete_#{Tweet.first.id}").click }.to change{Tweet.count}.by(-2)
    end

end
