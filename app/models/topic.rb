class Topic < ApplicationRecord
    has_many :posts, -> { order(created_at: :desc) }
    has_many :topic_views

    belongs_to :author, class_name: 'User', inverse_of: :created_topics

    accepts_nested_attributes_for :posts

    validates_presence_of :title, :author

    scope :recently_updated, -> { joins(:posts).order('posts.created_at DESC').uniq }
end
