class Category < ActiveRecord::Base
  has_many :activities
  has_many :words
  has_many :lessons
  has_many :users
end
