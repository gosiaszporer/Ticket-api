require 'rails_helper'

RSpec.describe ReservationDetail, type: :model do

  it { should belong_to(:reservation) }
  it { should belong_to(:ticket) }

  it { should validate_presence_of(:quantity) }
end
