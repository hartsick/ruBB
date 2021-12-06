require 'rails_helper'

RSpec.describe "Users", type: :system do
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

    expect(page).to have_content('welcome')
  end
end
