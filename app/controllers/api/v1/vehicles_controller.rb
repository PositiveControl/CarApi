module Api::V1
  class VehiclesController < ApplicationController
    include CarApiCommon::Controllers
    include Pipe

    def index
      render pipe({}, :through => [
        :initialize_response, :retrieve_vehicles, :serialize_vehicles
      ])
    end

    def create
      render pipe(vehicle_params.to_h, :through => [
        :initialize_response, :build_vehicle, :save_vehicle, :serialize_vehicles
      ])
    end

    def show
      render pipe(params[:id], :through => [
        :initialize_response, :get_vehicle, :serialize_vehicles
      ])
    end

    def update
      render pipe(vehicle_params, :through => [
        :initialize_response, :get_vehicle, :update_vehicle, :serialize_vehicles
      ])
    end

    def destroy
      render pipe({}, :through => [
        :initialize_response, :get_vehicle, :destroy_vehicle, :serialize_vehicles
      ])
    end

    private

    def vehicle_params
      params.require(:data).permit(:utility_class, :id)
    end
  end
end
