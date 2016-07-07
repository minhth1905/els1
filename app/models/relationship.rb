class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validate :followed_id, presence: true
  validate :follower_id, presence: true
end
