class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates_presence_of :name, :date
end
