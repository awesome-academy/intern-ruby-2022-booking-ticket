class Comment < ApplicationRecord
  belongs_to :user, :movie

  validates :user_id, :movie_id, presence: true
  validates :content, length: {maximum: Settings.digits.length_cmt_max}
end
