class User < ActiveRecord::Base
  has_many :categories
  has_many :activities
  has_many :words
  has_many :lessons
end
