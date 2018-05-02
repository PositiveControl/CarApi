require 'rails_helper'

RSpec.describe 'Vehicle' do
  describe 'retrieving an object' do
    context 'success' do
      it 'returns a object' do
        vehicle = create(:vehicle)

        expect(Vehicle.last).to eq(vehicle)
      end
    end
  end

  describe 'creating an object' do
    context 'success' do
      it 'returns object' do
        expect(
          create(:vehicle, :utility_class => 'sedan')
        ).to be_instance_of(Vehicle)
      end
    end

    context 'validation error' do
      it 'returns error' do
        expect{
          create(:vehicle, :utility_class => nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
