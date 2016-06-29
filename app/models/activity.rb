class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  belongs_to :category
end
