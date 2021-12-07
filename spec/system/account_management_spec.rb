require 'rails_helper'

RSpec.describe "Account management", type: :system do
  before do
    driven_by(:rack_test)

    create(:user, email: 'foo@example.com', password: 'password1234')
  end

  it "should allow logging into the account" do
    visit '/'

    click_on 'Sign in'

    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password1234'
    click_on 'Log in'

    expect(page).to have_content('all topics')

    click_on 'my profile'

    click_on 'edit'

    fill_in 'favorite food', with: 'country ham'
    click_on 'update'

    expect(page).to have_content('country ham')
  end
end
