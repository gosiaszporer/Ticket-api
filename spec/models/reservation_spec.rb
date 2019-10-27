require 'rails_helper'

RSpec.describe Reservation, type: :model do

  it { should have_many(:reservation_details).dependent(:destroy) }
  it { should have_many(:tickets).through(:reservation_details) }
  it { should belong_to(:event) }

  it { should validate_presence_of(:email) }
end
