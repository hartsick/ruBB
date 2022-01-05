require 'rails_helper'

RSpec.describe TopicView, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:topic_view)).to be_valid
  end
end
