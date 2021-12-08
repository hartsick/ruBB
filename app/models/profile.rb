class Profile < ApplicationRecord
    belongs_to :user

    validates_presence_of :about_me, :user
end
