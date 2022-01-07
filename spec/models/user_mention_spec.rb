require 'rails_helper'

RSpec.describe UserMention, type: :model do
  describe '.format_username_regex' do
    it 'should match existing users' do
      FactoryBot.create(:user, username: 'foo')
      expect(UserMention.format_username_regex).to match('@foo')
    end
    
    it 'should match newly created usernames' do
      UserMention.format_username_regex
      
      FactoryBot.create(:user, username: 'foo')
      
      expect(UserMention.format_username_regex).to match('@foo')
    end
  end
end
