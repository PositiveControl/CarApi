module Api::V1
  class VehiclesController < ApplicationController
    include Pipe
    include CarApiCommon::Controllers

    def index
      response = pipe({}, :through => [
        :initialize_response, :retrieve_vehicles, :serialize_vehicles
      ])

      render response
    end

    def create
      response = pipe(vehicle_params.to_h, :through => [
        :initialize_response, :build_vehicle, :save_vehicle,
        :serialize_vehicles
      ])

      render response
    end

    def show
      response = pipe(params[:id], :through => [
        :initialize_response, :get_vehicle, :serialize_vehicles
      ])

      render response
    end

    def update
      response  = pipe(vehicle_params, :through => [
        :initialize_response, :get_vehicle, :update_vehicle,
        :serialize_vehicles
      ])

      render response
    end

    def destroy
      response = pipe({}, :through => [
        :initialize_response, :get_vehicle,
        :destroy_vehicle, :serialize_vehicles
      ])

      render response
    end

    private

    def vehicle_params
      params.require(:data).permit(:utility_class, :id)
    end
  end
end
