require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe 'validations' do
    it 'requires a username' do
      expect(FactoryBot.build(:user, username: nil)).to_not be_valid
    end
    
    it 'requires that username be unique' do
      create(:user, username: 'piglet')
      expect(FactoryBot.build(:user, username: 'piglet')).to_not be_valid
    end

    it 'will not accept username of email in system' do
      create(:user, email: 'piglet@gmail.com')
      expect(FactoryBot.build(:user, username: 'piglet@gmail.com')).to_not be_valid
    end
  end

  describe '.has_invites_available?' do
    let(:inviter) { create(:user) }
    context 'when user has invited someone this month' do
      before do
        User.invite!({ email: 'new_user@example.com' }, inviter)
      end

      it 'should have no invites available' do
        expect(inviter.has_invites_available?).to eq(false)
      end
    end

    context 'when user has invited no one' do
      it 'should have invites available' do
        expect(inviter.has_invites_available?).to eq(true)
      end
    end

    context 'when user has not yet invited someone this month' do
      before do
        Timecop.freeze(2.months.ago) do
          User.invite!({ email: 'new_user@example.com' }, inviter)
        end
      end

      it 'should have invites available' do
        expect(inviter.has_invites_available?).to eq(true)
      end
    end
  end
end
