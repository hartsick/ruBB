require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:topic)).to be_valid
    expect{ FactoryBot.create(:topic) }.to change(Topic, :count).by(1)
  end
end
