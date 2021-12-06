class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :timeoutable, and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable

  has_many :created_topics, class_name: 'Topic', foreign_key: 'creator_id'
end
