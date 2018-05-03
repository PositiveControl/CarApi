require 'rails_helper'

RSpec.describe 'Model' do
  describe 'retrieving an object' do
    context 'success' do
      it 'returns a object' do
        model = create(:model)

        expect(Model.last).to eq(model)
      end
    end
  end

  describe 'creating an object' do
    context 'success' do
      it 'returns object' do
        expect(
          create(:model, :model_title => 'Huayra')
        ).to be_instance_of(Model)
      end
    end

    context 'validation error' do
      it 'returns error' do
        expect{
          create(:model, :model_title => nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
