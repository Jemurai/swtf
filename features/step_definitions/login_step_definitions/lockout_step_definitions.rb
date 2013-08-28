Then(/^the account should be locked out\.$/) do
# Then(/^the result should be "(.*?)"$/) do |arg1|
  11.times do 
    visit 'http://localhost:3000/users/sign_in'
    fill_in "Email", :with => @username
    fill_in "Password", :with => @password
    click_button "Sign in"
  end
  
  # TODO:  FIXME
  expect(page).to have_content 'Try again later'
  
end