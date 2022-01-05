require 'rails_helper'

RSpec.describe TopicHelper, type: :helper do
  describe ".unread_posts?" do
    it "returns true if topic has not been viewed" do
      expect(helper.unread_posts?(instance_double(Topic, id: 1), [])).to eq(true)
      expect(helper.unread_posts?(instance_double(Topic, id: 1), nil)).to eq(true)
    end

    it "returns true if last post is older than most recent topic view" do
      topic = FactoryBot.create(:topic,
        id: 3,
        posts: [
          FactoryBot.build(:post, created_at: 2.days.ago),
          FactoryBot.build(:post, created_at: Time.now),
        ]
      )

      topic_views = [double('topic view', created_at: 1.day.ago)]

      expect(helper.unread_posts?(topic, topic_views)).to eq(true)
    end

    it "returns false if most recent post is newer than most recent topic view" do
      topic = FactoryBot.create(:topic,
        id: 3,
        posts: [
          FactoryBot.build(:post, created_at: Time.now),
          FactoryBot.build(:post, created_at: 2.days.ago),
        ]
      )

      topic_views = [double('topic view', created_at: 1.day.ago)]

      expect(helper.unread_posts?(topic, topic_views)).to be_falsey
    end
  end

  describe ".unread_mentions?" do
    it 'returns true if latest mention is more recent than latest topic view' do
      mentions = [
        double('mention', created_at: 2.days.ago),
        double('mention', created_at: 1.day.ago)
      ]
      topic_views = [
        double('topic view', created_at: 3.days.ago),
        double('topic view', created_at: Time.now),
      ]

      expect(helper.unread_mentions?(mentions, topic_views)).to eq(true)
    end

    it 'returns true if mentions and no topic views' do
      mentions = [
        double('mention', created_at: 1.day.ago)
      ]

      expect(helper.unread_mentions?(mentions, [])).to eq(true)
    end

    it 'returns false if latest mention is earlier than latest topic view' do
      mentions = [
        double('mention', created_at: 2.days.ago),
        double('mention', created_at: 1.day.ago)
      ]
      topic_views = [
        double('topic view', created_at: Time.now),
        double('topic view', created_at: 3.days.ago),
      ]

      expect(helper.unread_mentions?(mentions, topic_views)).to be_falsey
    end

    it 'returns false if no mentions' do
      topic_views = [
        double('topic view', created_at: 3.days.ago),
        double('topic view', created_at: Time.now),
      ]

      expect(helper.unread_mentions?([], topic_views)).to be_falsey
    end
  end
end
