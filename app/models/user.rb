class User < ActiveRecord::Base
  before_save {email.downcase!}
  enum admin: [:is_guest, :is_admin]

  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.user_password_min}
  validates :name,  presence: true, length: {maximum: Settings.user_name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true, length: {maximum: Settings.user_email_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  USER_ATTRIBUTES = [:name, :email, :address, :password,
    :password_confirmation]

  has_many :categories
  has_many :activities
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_relationships, class_name:  Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :words
  has_many :lessons

  has_secure_password

  def is_user? current_user
    self == current_user
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
