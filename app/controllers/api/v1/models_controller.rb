module Api::V1
  class ModelsController < ApplicationController
    include CarApiCommon::Controllers
    include Pipe

    def index
      render pipe({}, :through => [
        :initialize_response, :retrieve_models, :filter_results,
        :serialize_models
      ])
    end

    def create
      render pipe(model_params.to_h, :through => [
        :initialize_response, :build_model, :save_model, :serialize_models
      ])
    end

    def show
      render pipe(params[:id], :through => [
        :initialize_response, :get_model, :serialize_models
      ])
    end

    def update
      render pipe(model_params, :through => [
        :initialize_response, :get_model, :update_model, :serialize_models
      ])
    end

    def destroy
      render pipe({}, :through => [
        :initialize_response, :get_model, :destroy_model, :serialize_models
      ])
    end

    private

    def filter_results(response)
      response.tap { |resp|
        resp[:model] = resp[:model].select { |model|
          model.make_id.to_s == params[:make_id]
        }
      }
    end

    def model_params
      params.require(:data).permit(:model_title, :id, :make_id)
    end
  end
end
