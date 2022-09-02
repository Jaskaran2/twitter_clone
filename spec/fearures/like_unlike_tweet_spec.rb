require "rails_helper"

RSpec.feature "like/unlike tweets",type: :feature do

    let!(:user){create(:user)}
    
    before do
        sign_in(user)
    end
    
    before do
        visit('/')
        expect(page).to have_content 'Home'
        fill_in 'tweet_body',with:"Test tweet"       
        click_button 'Tweet'
    end

    scenario "like tweet" do
        expect(page).to have_content "Test tweet" 
        expect { find(:css, '.fa-heart').click }.to change{Tweet.last.likes.count}.by(1)

    end

    scenario "unlike tweet" do
        expect(page).to have_content "Test tweet"
        find(:css, '.fa-heart').click
        visit('/')
        expect { find(:css, '.fa-heart').click }.to change{Tweet.last.likes.count}.by(-1)
    end

  
end
