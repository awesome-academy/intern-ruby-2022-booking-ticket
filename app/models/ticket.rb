class Ticket < ApplicationRecord
  belongs_to :payment, :show_time

  validates :show_time_id, presence: true
end
