class Profile < ApplicationRecord
    belongs_to :user

    validates_presence_of :user
    validates_presence_of :about_me, on: :update
end
