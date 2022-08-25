require "rails_helper"

RSpec.feature "Create tweets",type: :feature do

    feature "User is signed in" do

        before do
            user = User.create(name:"test",username:"test123",email:"test@gmail.com",password:"123456",password_confirmation:"123456")
            visit "/users/sign_in"
            fill_in 'Email',with: 'test@gmail.com'
            fill_in 'Password',with: '123456'
            click_button 'Log in'
            expect(page).to have_content 'Signed in successfully'
        end

        scenario "Tweet gets created" do
            visit('/')
            expect(page).to have_content 'Home'
            fill_in 'tweet_body',with:"Test tweet length>10"
            click_button 'Tweet'
            expect(page).to have_content "Test tweet length>10" 
        end
    end
end
