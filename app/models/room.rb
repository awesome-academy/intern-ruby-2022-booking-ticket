class Room < ApplicationRecord
  validates :cinema_id, presence: true

  has_many :show_times
  belongs_to :cinema
end
