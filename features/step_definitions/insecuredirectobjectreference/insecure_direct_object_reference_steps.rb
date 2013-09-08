Given(/^a new project created by a user$/) do
  uuid = SecureRandom.uuid
  @user1 = "fb_user_1_#{uuid}@jemurai.com"
  register_as_user(@user1, "password")
  logout(@user1)
  login_as_user(@user1, 'password')
  new_project("Insecure Deirect Object Reference #{uuid}", "Forceful Browsing Desc")
  @url = current_url 
end

When(/^a different person attempts to access the project$/) do
  logout(@user1)
  uuid = SecureRandom.uuid
  @user2 = "fb_user_2_#{uuid}@jemurai.com"
  register_as_user(@user2, "password")
  logout(@user2)
  login_as_user(@user2, 'password')
end

Then(/^the system should prevent access$/) do
  visit @url
  expect(page).not_to have_content "Forceful Browsing Desc"
end