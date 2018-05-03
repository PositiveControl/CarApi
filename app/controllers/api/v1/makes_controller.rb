module Api::V1
  class MakesController < ApplicationController
    include CarApiCommon::Controllers
    include Pipe

    def index
      render pipe({}, :through => [
        :initialize_response, :retrieve_makes, :serialize_makes
      ])
    end

    def create
      render pipe(make_params.to_h, :through => [
        :initialize_response, :build_make, :save_make, :serialize_makes
      ])
    end

    def show
      render pipe(params[:id], :through => [
        :initialize_response, :get_make, :serialize_makes
      ])
    end

    def update
      render pipe(make_params, :through => [
        :initialize_response, :get_make, :update_make, :serialize_makes
      ])
    end

    def destroy
      render pipe({}, :through => [
        :initialize_response, :get_make, :destroy_make, :serialize_makes
      ])
    end

    private

    def make_params
      params.require(:data).permit(:brand, :id)
    end
  end
end
