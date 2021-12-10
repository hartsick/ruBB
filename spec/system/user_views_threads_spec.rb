require 'rails_helper'

RSpec.describe "Creating and viewing topics", type: :system do
  let(:poster) { create(:user, email: 'poster@example.com', password: 'password1234') }
  let(:viewer) { create(:user, email: 'viewer@example.com', password: 'password1234') }
  
  before do
    driven_by(:rack_test)

    sign_in poster
  end

  it 'shows posts from "today" on the main page' do
    create(:topic, title: 'this is an old topic', author: poster, created_at: 3.days.ago)

    visit '/'

    expect(page.all(:xpath, "//table/tbody/tr").length).to eq(0)

    click_on 'new topic'

    fill_in 'title', with: 'dog thread for today'
    fill_in 'body', with: "here is a text description of Pig since images aren't supported"
    click_on 'post'

    click_on 'back to topics'

    expect(page).to have_content "today's topics"
    expect(page).to have_content 'dog thread for today'

    click_on "yesterday's news"

    click_on 'this is an old topic'

    fill_in 'reply', with: 'bring it to the front'
    click_on 'post'

    click_on 'back to topics'

    expect(page).to have_content "today's topics"
    expect(page).to have_content 'dog thread for today'
    expect(page).to have_content 'this is an old topic'
  end

  it "should allow logged in user to create a new topic and view it" do
    visit '/'

    click_on 'new topic'

    fill_in 'title', with: 'post your dogs'
    fill_in 'body', with: "here is a text description of Pig since images aren't supported"
    click_on 'post'

    expect(page).to have_content 'post your dogs'
    click_on 'back to topics'

    expect(page).to have_content "today's topics"
    expect(page).to have_content 'post your dogs'

    logout
    sign_in viewer

    visit '/'

    click_on 'post your dogs'
    expect(page).to have_content 'post your dogs'

    fill_in 'reply', with: 'thanks I appreciate it'
    click_on 'post'

    click_on "back to topics"

    expect(page).to have_content(2)
  end

  it 'shows notifications for unread posts' do
    create(:topic, title: 'this is a topic', author: poster)
    create(:topic, title: 'but this is the one I made', author: viewer)

    visit '/'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('but this is the one I made')
    expect(first_row).to have_content('(unread)')

    click_on 'but this is the one I made'

    click_on 'home'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('but this is the one I made')
    expect(first_row).to_not have_content('(unread)')

    logout
    login_as(viewer)

    visit '/'

    click_on 'but this is the one I made'
    fill_in 'reply', with: 'hope you like notifications'
    click_on 'post'

    logout
    login_as(poster)

    visit '/'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('but this is the one I made')
    expect(first_row).to have_content('(unread)')
  end
end
