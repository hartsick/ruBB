class UserMention < ApplicationRecord
    belongs_to :user
    belongs_to :post

    CAPTURE_USERNAME_REGEX = /@(\w+)/

    def self.format_username_regex
        all_usernames = User.pluck(:username).map{|username| Regexp.escape("@#{username}")}
        @format_username_regex = Regexp.union(all_usernames)
    end

    def self.associate_mentions_in_post!(post)
        username_mentions = post.body.scan(CAPTURE_USERNAME_REGEX).flatten.uniq
        return unless username_mentions.any?

        user_mentions = User.where(username: username_mentions)
        return unless user_mentions.any?

        now = Time.now
        insert_all!(user_mentions.map{|user| { user_id: user.id, post_id: post.id, created_at: now, updated_at: now } })
    end
end
