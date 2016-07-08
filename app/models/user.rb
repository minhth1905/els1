class User < ActiveRecord::Base
  before_save {email.downcase!}

  validates :password, presence: true, length: {minimum: 6}
  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  USER_ATTRIBUTES = [:name, :email, :address, :password,
    :password_confirmation]

  has_many :categories
  has_many :activities
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_relationships, class_name:  Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :words
  has_many :lessons

  has_secure_password

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
