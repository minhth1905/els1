class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :lesson
  belongs_to :category
end
