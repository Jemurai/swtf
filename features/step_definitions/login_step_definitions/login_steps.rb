Given(/^the username is "(.*?)"$/) do |arg1|
  @username = arg1
end

When(/^the password is "(.*?)"$/) do |arg1|
  @password = arg1
end

Then(/^the result should be "(.*?)"$/) do |arg1|
  @result = arg1
  uuid = SecureRandom.uuid
  user = "login_user_#{@username}_#{uuid}@jemurai.com"
  register_as_user(user, "password")
  
  logout(user)
  
  login_as_user(user, @password)
    
  if @result == "fail"
    expect(page).to have_content 'Sign in'
  else  
    expect(page).to have_content 'Dashboard'
  end
  
end