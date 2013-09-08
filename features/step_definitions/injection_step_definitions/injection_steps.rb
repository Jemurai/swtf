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