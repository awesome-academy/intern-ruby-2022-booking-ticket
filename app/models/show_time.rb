class ShowTime < ApplicationRecord
  has_many :tickets
  belongs_to :movie, :room

  validates :movie_id, :room_id, presence: true
end
