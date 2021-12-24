class Post < ApplicationRecord
    belongs_to :topic, optional: true
    belongs_to :author, class_name: 'User', inverse_of: :posts

    has_many :user_mentions

    validates_presence_of :body, :author
end
