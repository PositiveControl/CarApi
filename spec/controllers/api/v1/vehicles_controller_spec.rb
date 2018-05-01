require 'rails_helper'

RSpec.describe Api::V1::VehiclesController, type: :controller do
  include ApiResponseHelper

  describe '#create' do
    context 'success' do
      it 'creates an object' do
        post :create,
          :format => :json,
          :params => {
            :vehicle => {:utility_class => 'SUV'}
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns an error' do
        post :create,
          :format => :json,
          :params => {
            :vehicle => {:utility_class => nil}
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end
end