require 'rails_helper'

RSpec.describe 'Option' do
  describe 'retrieving an object' do
    context 'success' do
      it 'returns a object' do
        option = create(:option, :name => 'Power Windows')

        expect(Option.last).to eq(option)
      end
    end
  end

  describe 'creating an object' do
    context 'success' do
      it 'returns object' do
        expect(
          create(:option, :name => 'Sport Exhaust')
        ).to be_instance_of(Option)
      end
    end

    context 'validation error' do
      it 'returns error' do
        expect{
          create(:option, :name => nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
