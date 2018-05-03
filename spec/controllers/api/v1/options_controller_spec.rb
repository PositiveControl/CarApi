require 'rails_helper'

RSpec.describe Api::V1::OptionsController, type: :controller do
  include ApiResponseHelper

  describe '#index' do
    context 'success' do
      it 'returns a successful response' do
        create(:option)

        get :index, :format => :json

        expect(response).to be_success
      end

      context 'success' do
        it 'returns requested object' do
          create(:option)

          get :index, :format => :json

          expect(objects.first['id']).to be_present
        end

        it 'returns multiple requested objects' do
          10.times {
            create(:option, :name => "#{rand(10000)}")
          }

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
            :data => {
              :name => 'Chrome Grill',
              :description => 'It is not for cooking.'
            }
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns an error' do
        post :create,
          :format => :json,
          :params => {
            :data => { :name => nil }
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end

  describe '#show' do
    let(:option) { create(:option) }

    context 'success' do
      it 'creates an object' do
        get :show,
          :format => :json,
          :params => { :id => option.id }

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

  describe '#update' do
    context 'success' do
      it 'returns successful response' do
        option = create(:option)

        put :update,
          :format => :json,
          :params => {
            :id => option.id,
            :data => {
              :name => 'Runflat Tires',
              :description => 'Best tires for beating the cops!'
            }
          }

        expect(response).to be_success
      end

      it 'updates an object' do
        option = create(:option)

        expect(option.name).to_not eq('Alligator Skin Seats')

        put :update,
          :format => :json,
          :params => {
            :id => option.id,
            :data => {
              :name => 'Alligator Skin Seats',
            }
          }

        expect(
          objects['attributes']['name']
        ).to eq('Alligator Skin Seats')
      end
    end

    context 'failure' do
      it 'returns an error' do
        option = create(:option)
        post :create,
          :format => :json,
          :params => {
            :id => option.id,
            :data => {
              :name => nil,
              :description => 'Best tires for beating the cops!'
            }
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end

  describe '#destroy' do
    context 'success' do
      it 'returns successful response' do
        option = create(:option)

        delete :destroy,
          :format => :json,
          :params => { :id => option.id }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns a not found error' do
        delete :destroy,
          :format => :json,
          :params => { :id => 0 }

        expect(response.status).to eq(404)
        expect(errors).to be_present
      end
    end
  end
end
