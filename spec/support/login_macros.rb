module LoginMacros
# controller login helper omitted ...
  def sign_in(user)
    visit "/users/sign_in"
    fill_in 'Email',with: user.email
    fill_in 'Password',with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
