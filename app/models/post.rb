class Post < ApplicationRecord
    belongs_to :topic

    belongs_to :author, class_name: 'User', inverse_of: :posts
end
