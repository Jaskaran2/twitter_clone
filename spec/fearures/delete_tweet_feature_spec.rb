require "rails_helper"

RSpec.feature "delete tweets",type: :feature do

    feature "User is signed in" do
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
    end
end
