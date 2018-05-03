module Api::V1
  class OptionsController < ApplicationController
    include CarApiCommon::Controllers
    include Pipe

    def index
      render pipe({}, :through => [
        :initialize_response, :retrieve_options, :serialize_options
      ])
    end

    def create
      render pipe(option_params.to_h, :through => [
        :initialize_response, :build_option, :save_option, :serialize_options
      ])
    end

    def show
      render pipe(params[:id], :through => [
        :initialize_response, :get_option, :serialize_options
      ])
    end

    def update
      render pipe(option_params, :through => [
        :initialize_response, :get_option, :update_option, :serialize_options
      ])
    end

    def destroy
      render pipe({}, :through => [
        :initialize_response, :get_option, :destroy_option, :serialize_options
      ])
    end

    private

    def option_params
      params.require(:data).permit(:name, :description, :id)
    end
  end
end
