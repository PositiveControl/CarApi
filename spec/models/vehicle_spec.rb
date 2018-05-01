require 'rails_helper'

RSpec.describe 'Vehicle' do
  describe 'retrieving an object' do
    it 'returns a vehicle' do
      vehicle = create(:vehicle)

      expect(Vehicle.find(1)).to eq(vehicle)
    end
  end
end
