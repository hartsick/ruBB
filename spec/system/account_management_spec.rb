require 'rails_helper'
require 'capybara/email/rspec'

RSpec.describe "Account management", type: :system do
  let!(:user) { create(:user, username: 'foobar', email: 'foo@example.com', password: 'password1234') }

  before do
    driven_by(:rack_test)
  end

  it "should allow logging into the account" do
    visit '/'

    click_on 'sign in'

    fill_in 'username or email', with: 'foobar'
    fill_in 'password', with: 'password1234'
    click_on 'log in'

    expect(page).to have_content("topics")

    click_on 'my profile'

    click_on 'edit'

    fill_in 'whatever you want here', with: 'country ham'
    click_on 'update'

    expect(page).to have_content('country ham')
  end

  it "should allow users to invite other users" do
    sign_in user

    visit '/'

    click_on 'my profile'
    click_on 'invite someone'

    fill_in 'email', with: 'hello@example.com'
    click_on 'invite'

    expect(page).to have_content 'An invitation email has been sent to hello@example.com'

    click_on 'directory'
    expect(page).to have_content 'the poster list' # Don't break if invite not accepted

    sign_out user
    
    open_email "hello@example.com"
    current_email.click_link 'Accept invitation'

    fill_in 'username', with: 'tinytoad'
    fill_in 'new password', with: 'love a little toadstool'
    fill_in 'confirm new password', with: 'love a little toadstool'
    click_on 'create account'

    expect(page).to have_text 'Your password was set successfully'

    click_on 'directory'
    expect(page).to have_content 'the poster list'
    expect(page).to have_content 'tinytoad'
  end
end
