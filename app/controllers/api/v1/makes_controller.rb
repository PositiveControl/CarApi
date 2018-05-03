module Api::V1
  class MakesController < ApplicationController
    include Pipe
    include CarApiCommon::Controllers

    def index
      response = pipe({}, :through => [
        :initialize_response, :retrieve_makes, :serialize_makes
      ])

      render response
    end

    def create
      response = pipe(make_params.to_h, :through => [
        :initialize_response, :build_make, :save_make,
        :serialize_makes
      ])

      render response
    end

    def show
      response = pipe(params[:id], :through => [
        :initialize_response, :get_make, :serialize_makes
      ])

      render response
    end

    def update
      response  = pipe(make_params, :through => [
        :initialize_response, :get_make, :update_make,
        :serialize_makes
      ])

      render response
    end

    def destroy
      response = pipe({}, :through => [
        :initialize_response, :get_make,
        :destroy_make, :serialize_makes
      ])

      render response
    end

    private

    def make_params
      params.require(:data).permit(:brand, :id)
    end
  end
end
