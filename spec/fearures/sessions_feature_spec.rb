require "rails_helper"

RSpec.feature "Login user",type: :feature do
    #before{User.create(name:"test",username:"test123",email:"test@gmail.com",password:"123456",password_confirmation:"123456")}
    before{create(:user)}
    
    feature "successful login" do
        scenario "User logins successfully" do
            visit "/users/sign_in"
            fill_in "Email",with: "test@gmail.com"
            fill_in "Password",with: "123456"
            click_button 'Log in'
            expect(page).to have_content 'Signed in successfully'
        end
    end

    feature "Unsuccessful login" do
        scenario "User cannot login due to invalid mail" do
            visit "/users/sign_in"
            fill_in "Email",with: "test_invalid@gmail.com"
            fill_in "Password",with: "123456"
            click_button 'Log in'
            expect(page).to have_content 'Invalid Email or password.'
        end

        scenario "User  cannot login due to invalid password" do
            visit "/users/sign_in"
            fill_in "Email",with: "test_invalid@gmail.com"
            fill_in "Password",with: "123455"
            click_button 'Log in'
            expect(page).to have_content 'Invalid Email or password.'
        end
    end
end