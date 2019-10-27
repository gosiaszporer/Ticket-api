class Reservation < ApplicationRecord
  belongs_to :event
  has_many :reservation_details, dependent: :destroy
  has_many :tickets, through: :reservation_details

  validates_presence_of :email

  enum status: { pending: 0, rejected: 1, accepted: 2, exceeded: 3 }

  def time_limit
    created_at + 15*60
  end
end
