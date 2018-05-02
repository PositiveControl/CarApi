require 'rails_helper'

RSpec.describe Api::V1::VehiclesController, type: :controller do
  include ApiResponseHelper

  describe '#index' do
    context 'success' do
      it 'returns a successful response' do
        create(:vehicle)

        get :index, :format => :json

        expect(response).to be_success
      end

      context 'success' do
        it 'returns requested object' do
          create(:vehicle)

          get :index, :format => :json

          expect(objects.first['id']).to be_present
        end

        it 'returns multiple requested objects' do
          10.times { create(:vehicle) }

          get :index, :format => :json

          expect(objects.count).to eq(10)
        end
      end
    end
  end

  describe '#create' do
    context 'success' do
      it 'creates an object' do
        post :create,
          :format => :json,
          :params => {
            :data => { :utility_class => 'SUV' }
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns an error' do
        post :create,
          :format => :json,
          :params => {
            :data => { :utility_class => nil }
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end

  describe '#show' do
    let(:vehicle) { create(:vehicle) }

    context 'success' do
      it 'creates an object' do
        get :show,
          :format => :json,
          :params => { :id => vehicle.id }

        expect(response).to be_success
      end
    end

    context 'not found' do
      it 'returns an error' do
        get :show,
          :format => :json,
          :params => { :id => 0 }

        expect(response.status).to eq(404)
      end
    end
  end
end
