require 'rails_helper'

RSpec.describe Ticket, type: :model do
  
  it { should have_many(:reservation_details) }
  it { should have_many(:reservations).through(:reservation_details) }
  it { should belong_to(:event) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:quantity) }
end
