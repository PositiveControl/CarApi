require 'rails_helper'

RSpec.describe Api::V1::ModelsController, type: :controller do
  include ApiResponseHelper

  let!(:make) { create(:make) }

  describe '#index' do
    context 'success' do
      it 'returns a successful response' do
        create(:model, :make => make)

        get :index, :format => :json, :params => { :make_id => make.id }

        expect(response).to be_success
      end

      context 'success' do
        it 'returns requested object' do
          create(:model, :make => make)

          get :index, :format => :json, :params => { :make_id => make.id }

          expect(objects.first['id']).to be_present
        end

        it 'returns multiple requested objects' do
          10.times { create(:model, :make => make) }

          get :index, :format => :json, :params => { :make_id => make.id }

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
            :make_id => make.id,
            :data => { :model_title => 'Windstar', :make_id => make.id }
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns an error' do
        post :create,
          :format => :json,
          :params => {
            :make_id => make.id,
            :data => { :model_title => nil }
          }

        expect(response.status).to eq(400)
        expect(errors).to be_present
      end
    end
  end

  describe '#show' do
    let(:model) { create(:model, :make => make) }

    context 'success' do
      it 'creates an object' do
        get :show,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => model.id
          }

        expect(response).to be_success
      end
    end

    context 'not found' do
      it 'returns an error' do
        get :show,
          :make_id => make.id,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => 0
          }

        expect(response.status).to eq(404)
      end
    end
  end

  describe '#update' do
    context 'success' do
      it 'returns successful response' do
        model = create(:model, :make => make)

        put :update,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => model.id,
            :data => {
              :model_title => 'Pagani'
            }
          }

        expect(response).to be_success
      end

      it 'updates an object' do
        model = create(:model, :make => make)

        expect(model.model_title).to_not eq('Fisker')

        put :update,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => model.id,
            :data => {
              :model_title => 'Fisker'
            }
          }

        expect(
          objects['attributes']['model_title']
        ).to eq('Fisker')
      end
    end

    context 'failure' do
      it 'returns an error' do
        model = create(:model, :make => make)
        post :create,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => model.id,
            :data => {
              :model_title => nil
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
        model = create(:model, :make => make)

        delete :destroy,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => model.id
          }

        expect(response).to be_success
      end
    end

    context 'failure' do
      it 'returns a not found error' do
        delete :destroy,
          :format => :json,
          :params => {
            :make_id => make.id,
            :id => 0
          }

        expect(response.status).to eq(404)
        expect(errors).to be_present
      end
    end
  end
end
