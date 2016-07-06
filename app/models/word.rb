class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers

  scope :learned, ->(current_user_id){
    where("words.id in (select word_id from results where user_id = ?)", current_user_id)}
  scope :notlearned, ->(current_user_id){
    where("words.id not in (select word_id from results where user_id = ?)", current_user_id)}
end
