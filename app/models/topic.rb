class Topic < ApplicationRecord
    belongs_to :creator, class_name: 'User', inverse_of: :created_topics
end
