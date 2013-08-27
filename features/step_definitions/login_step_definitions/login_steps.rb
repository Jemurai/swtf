Given(/^the username is "(.*?)"$/) do |arg1|
  @username = arg1
end

When(/^the password is "(.*?)"$/) do |arg1|
  @password = arg1
end

Then(/^the result should be "(.*?)"$/) do |arg1|
  @result = arg1
  visit 'http://localhost:3000/users/sign_in'
  fill_in "Email", :with => @username
  fill_in "Password", :with => @password
  click_button "Sign in"
  
  if @result == "fail"
    expect(page).to have_content 'Sign in'
  else  
    expect(page).to have_content 'Dashboard'
  end
  
end