module Api::V1
  class VehiclesController < ApplicationController
    include Pipe

    def create
      response = pipe(vehicle_params, :through => [
        :initialize_response, :build_vehicle,
        :create_vehicle, :serialize_response
      ])

      render response
    end

    private

    def initialize_response(response)
      response.to_h
    end

    def build_vehicle(response)
      response.tap { |resp|
        resp.merge!(
          :vehicle => Vehicle.new(vehicle_params)
        )
      }
    end

    def create_vehicle(response)
      response.tap { |resp|
        begin
          resp[:success] = resp[:vehicle].save!
        rescue => error
          resp.merge!(:error => error)
        end
      }
    end

    def serialize_response(response)
      if response[:error]
        { :json => response[:error], :status => 400 }
      elsif response[:success]
        { :json => response[:success], :status => 201 }
      elsif response[:vehicle]
        {
          :json => VehicleSerializer
            .new(response[:vehicle])
            .serializable_hash,
          :status => 200
        }
      else
        { :json => 'UnhandledExeption', :status => 400 }
      end
    end

    def vehicle_params
      params.require(:vehicle).permit(:utility_class)
    end
  end
end
