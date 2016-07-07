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
  has_many :words
  has_many :lessons
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
    class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_secure_password

  def following?(other_user)
    relationships.find_by(followed_id: other_user)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user).destroy
  end
end
