Given(/^a new project created by a user$/) do
  uuid = SecureRandom.uuid
  @user1 = "fb_user_1_#{uuid}@jemurai.com"
  register_as_user(user, "password")
  logout(user)
  login_as_user(user, 'password')
  new_project("Insecure Deirect Object Reference #{uuid}", "Forceful Browsing Desc")
  @url = current_url 
  logout
end

When(/^a different person attempts to access the project$/) do
  uuid = SecureRandom.uuid
  @user2 = "fb_user_2_#{uuid}@jemurai.com"
  register_as_user(user, "password")
  logout(user)
  login_as_user(user, 'password')
end

Then(/^the system should prevent access$/) do
  visit @url
  
  expect(page).to have_content "Forceful Browsing Desc"
end