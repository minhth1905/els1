class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results

  validates :national, presence: true, length: {maximum: 30}

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|a| a[:meaning].blank?}, allow_destroy: true

  scope :learned, ->(current_user_id){
    where("words.id in (select word_id from results where user_id = ?)", current_user_id)}
  scope :notlearned, ->(current_user_id){
    where("words.id not in (select word_id from results where user_id = ?)", current_user_id)}
end
