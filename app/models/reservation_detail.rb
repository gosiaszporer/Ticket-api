class ReservationDetail < ApplicationRecord
  belongs_to :ticket
  belongs_to :reservation

  validates_presence_of :quantity
end
