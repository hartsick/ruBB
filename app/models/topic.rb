class Topic < ApplicationRecord
    has_many :posts

    belongs_to :author, class_name: 'User', inverse_of: :created_topics

    accepts_nested_attributes_for :posts

    scope :recently_updated, -> { joins(:posts).order('posts.created_at DESC').uniq }
end
