require "rails_helper"

RSpec.feature "Delete user",type: :feature do
    let(:user){create(:user)}

    before do
        sign_in(user)
    end

    scenario "delete user" do
        expect(page).to have_content "Home"
        find(:css, '.sidebarOption_profile').click 
        expect(page).to have_content User.last.name    
        find(:css, '.fa-gear').click  
        expect(page).to  have_content "Edit User"
        fill_in 'user_current_password',with: user.password
        expect{click_button 'Cancel my account'}.to change{User.count}.by(-1)
    end
end