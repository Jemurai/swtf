# Test for simple sql injection 
When(/^the user alters the location in browser to attempt sqli$/) do
  @url = current_url 
  @inject_string = ") or 1=1 --"
  @url = @url + @inject_string
  puts @url
end

Then(/^the system should display no projects$/) do
  visit @url
  expect(page).not_to have_content "Rich Description:"
end

# Test for command injection
Given(/^a new project created by a user for injection$/) do
  uuid = SecureRandom.uuid
  @user1 = "fb_user_1_#{uuid}@jemurai.com"
  register_as_user(@user1, "password")
#  logout(@user1)
#  login_as_user(@user1, 'password')
  new_project("Injection Project", "Injection Project")
  @url = current_url 
end

When(/^the user puts shell code in the form field$/) do
  @inject_code = "; cat /etc/passwd > public/passwd.html; cat /etc/passwd > /tmp/pwned"
  click_link 'Edit'
  fill_in "project[name]", :with => @inject_code
  click_button "Update Project"
end

Then(/^the system should prevent arbitrary execution$/) do
    click_link 'Back'
    click_button 'Destroy'
    page.driver.browser.switch_to.alert.accept      
    visit '/passwd.html'
    expect(page).not_to have_content "root"
end