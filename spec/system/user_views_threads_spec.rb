require 'rails_helper'

RSpec.describe "Creating and viewing topics", type: :system do
  let!(:poster) { create(:user, username: 'poster', email: 'poster@example.com', password: 'password1234') }
  let!(:viewer) { create(:user, username: 'viewer', email: 'viewer@example.com', password: 'password1234') }
  
  before do
    driven_by(:rack_test)

    sign_in poster
  end

  it "should allow logged in user to create a new topic and view it" do
    visit '/'

    click_on 'new topic'

    fill_in 'title', with: 'post your dogs'
    fill_in 'body', with: "here is a text description of Pig since images aren't supported"
    click_on 'post'

    expect(page).to have_content 'post your dogs'
    click_on 'back to topics'

    expect(page).to have_content 'topics'
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
    create(:topic, title: 'this is a topic', author: poster, created_at: 1.day.ago)
    create(:topic, title: 'but this is the one I made', author: viewer, created_at: Time.now)

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

  it 'shows notifications for mentions and allows accessing past mentions' do
    visit '/'

    click_on 'new topic'

    fill_in 'title', with: 'hello thread'
    fill_in 'body', with: "hey @viewer"
    click_on 'post'

    logout
    sign_in viewer

    visit '/'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('hello thread')
    expect(first_row).to have_content('mentioned')

    click_on 'hello thread'
    fill_in 'reply', with: 'hi @poster'
    click_on 'post'
    click_on 'back to topics'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('hello thread')
    expect(first_row).to_not have_content('mentioned')

    logout
    sign_in poster

    visit '/'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('hello thread')
    expect(first_row).to have_content('mentioned')

    click_on '@s'

    first_row = page.all(:xpath, "//table/tbody/tr").first
    expect(first_row).to have_content('hello thread')
  end
end
