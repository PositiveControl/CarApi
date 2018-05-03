require 'rails_helper'

RSpec.describe Api::V1::MakesController, type: :controller do
  include ApiResponseHelper

  describe '#index' do
    context 'success' do
      it 'returns a successful response' do
        create(:make)

        get :index, :format => :json

        expect(response).to be_success
      end

      context 'success' do
        it 'returns requested object' do
          create(:make)

          get :index, :format => :json

          expect(objects.first['id']).to be_present
        end

        it 'returns multiple requested objects' do
          10.times { create(:make) }

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
            :data => { :brand => 'Ford' }
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns an error' do
        post :create,
          :format => :json,
          :params => {
            :data => { :brand => nil }
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end

  describe '#show' do
    let(:make) { create(:make) }

    context 'success' do
      it 'creates an object' do
        get :show,
          :format => :json,
          :params => { :id => make.id }

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
        make = create(:make)

        put :update,
          :format => :json,
          :params => {
            :id => make.id,
            :data => {
              :brand => 'Pagani'
            }
          }

        expect(response).to be_success
      end

      it 'updates an object' do
        make = create(:make)

        expect(make.brand).to_not eq('Fisker')

        put :update,
          :format => :json,
          :params => {
            :id => make.id,
            :data => {
              :brand => 'Fisker'
            }
          }

        expect(
          objects['attributes']['brand']
        ).to eq('Fisker')
      end
    end

    context 'failure' do
      it 'returns an error' do
        make = create(:make)
        post :create,
          :format => :json,
          :params => {
            :id => make.id,
            :data => {
              :brand => nil
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
        make = create(:make)

        delete :destroy,
          :format => :json,
          :params => { :id => make.id }

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
