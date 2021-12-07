require 'rails_helper'

RSpec.describe "Creating and viewing topics", type: :system do
  let(:poster) { create(:user, email: 'poster@example.com', password: 'password1234') }
  let(:viewer) { create(:user, email: 'viewer@example.com', password: 'password1234') }
  
  before do
    driven_by(:rack_test)

    sign_in poster
  end

  it "should allow logged in user to create a new topic and view it" do
    visit '/'

    expect(page).to have_content ''

    click_on 'New topic'

    fill_in 'Title', with: 'post your dogs'
    fill_in 'Body', with: "here is a text description of Pig since images aren't supported"
    click_on 'Post'

    expect(page).to have_content 'post your dogs'
    click_on 'See all topics'

    expect(page).to have_content 'All topics'
    expect(page).to have_content 'post your dogs'

    logout

    sign_in viewer

    visit '/'

    click_on 'post your dogs'
    expect(page).to have_content 'post your dogs'

    fill_in 'Body', with: 'thanks I appreciate it'
    click_on 'Reply'

    click_on 'See all topics'

    expect(page).to have_content(2)
  end
end
