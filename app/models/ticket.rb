class Ticket < ApplicationRecord
  belongs_to :event
  has_many :reservation_details
  has_many :reservations, through: :reservation_details

  validates_presence_of :name, :price, :quantity
end
