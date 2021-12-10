require 'rails_helper'

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

    expect(page).to have_content("today's topics")

    click_on 'my profile'

    click_on 'edit'

    fill_in 'whatever you want here', with: 'country ham'
    click_on 'update'

    expect(page).to have_content('country ham')
  end
end
