class Payment < ApplicationRecord
  has_many :tickets
  belongs_to :user
  
  validates :user_id, :ticket_id, presence: true
end
