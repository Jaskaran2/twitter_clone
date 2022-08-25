require "rails_helper"


RSpec.feature "Create user",type: :feature do
    
    feature "successful user creation" do

        scenario "User gets created" do
            visit('/users/sign_up')
            fill_in 'Name',with: 'Test'
            fill_in 'user_name',with: 'test123'
            fill_in 'Email',with: 'test@gmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'user_password_confirmation',with: '123456'
            click_button 'Sign up'
            expect(page).to have_content 'Welcome! You have signed up successfully.'
        end

    end

    feature "Unsuccessful user creation" do

       #before{create(:user)}
       before{User.create(name:"test1",username:"teste12345",email:"Test432@gmail.com",password:"123456",password_confirmation:"123456")}
        
        scenario "User does not get created due to invalid mail" do
            visit('/users/sign_up')
            fill_in 'Name',with: 'Test'
            fill_in 'user_name',with: 'test123'
            fill_in 'Email',with: 'Testgmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'user_password_confirmation',with: '123456'
            click_button 'Sign up'
            expect(page).to have_content 'Email is invalid'
        end

        scenario "User does not get created as email is taken" do
            visit('/users/sign_up')
            fill_in 'Name',with: 'Test'
            fill_in 'user_name',with: 'test123'
            fill_in 'Email',with: 'Test432@gmail.com'
            fill_in 'Password',with: '123456'
            fill_in 'user_password_confirmation',with: '123456'
            click_button 'Sign up'
            expect(page).to have_content 'Email has already been taken'
        end


        scenario "User does not get created as password confirmation dosent match" do
            visit('/users/sign_up')
            fill_in 'Name',with: 'Test'
            fill_in 'user_name',with: 'test123'
            fill_in 'Email',with: 'test@gmail.com'
            fill_in 'Password',with: '123455'
            fill_in 'user_password_confirmation',with: '123456'
            click_button 'Sign up'
            expect(page).to have_content 'Password confirmation doesn\'t match Password'
        end

        scenario "User does not get created as password < 6" do
            visit('/users/sign_up')
            fill_in 'Name',with: 'Test'
            fill_in 'user_name',with: 'test123'
            fill_in 'Email',with: 'test@gmail.com'
            fill_in 'Password',with: '1234'
            fill_in 'user_password_confirmation',with: '1234'
            click_button 'Sign up'
            expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end 
    end

end