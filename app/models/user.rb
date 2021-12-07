class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :timeoutable, and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable

  has_one :profile

  has_many :created_topics, class_name: 'Topic', foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  before_create { build_profile }
end
