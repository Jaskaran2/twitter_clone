# module ToggleUserMacros
#     def create_tweet_signout_current_signin_another(user)
#         visit('/')
#         fill_in 'tweet_body',with:"Test tweet"       
#         click_button 'Tweet'
#         find(:css, '.logout_button').click
#         visit "/users/sign_in"
#         fill_in 'Email',with: user.email
#         fill_in 'Password',with: user.password
#         click_button 'Log in'
#         expect(page).to have_content 'Signed in successfully'
#     end

#     def signout_current_signin_another(user)
#         visit('/')
#         find(:css, '.logout_button').click
#         visit "/users/sign_in"
#         fill_in 'Email',with: user.email
#         fill_in 'Password',with: user.password
#         click_button 'Log in'
#         expect(page).to have_content 'Signed in successfully'
#     end
# end