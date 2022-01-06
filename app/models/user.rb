class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :timeoutable, and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :invitable

  has_one :profile

  has_many :created_topics, class_name: 'Topic', foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :topic_views, -> { order(created_at: :desc) }
  has_many :topic_follows, -> { order(created_at: :desc) }
  has_many :invitations, class_name: 'User', as: :invited_by

  before_create { build_profile }

  validate :validate_username
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username, uniqueness: { case_sensitive: false }, presence: true

  def has_invites_available?
    return true if invitations.none?
    invitations.order(invitation_created_at: :desc).limit(1).pluck(:invitation_created_at).first < DateTime.now.beginning_of_month
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def to_param
    username
  end

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
