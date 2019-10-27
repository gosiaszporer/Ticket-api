require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should have_many(:tickets).dependent(:destroy) }
  it { should have_many(:reservations).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
end
