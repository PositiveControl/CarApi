require 'rails_helper'

RSpec.describe 'Make' do
  describe 'retrieving an object' do
    context 'success' do
      it 'returns a object' do
        make = create(:make)

        expect(Make.last).to eq(make)
      end
    end
  end

  describe 'creating an object' do
    context 'success' do
      it 'returns object' do
        expect(
          create(:make, :brand => 'BMW')
        ).to be_instance_of(Make)
      end
    end

    context 'validation error' do
      it 'returns error' do
        expect{
          create(:make, :brand => nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
