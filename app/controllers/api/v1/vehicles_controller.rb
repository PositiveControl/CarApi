module Api::V1
  class VehiclesController < ApplicationController
    include Pipe

    def index
      response = pipe({}, :through => [
        :initialize_response, :get_vehicles,
        :serialize_response
      ])

      render response
    end

    def create
      response = pipe(vehicle_params.to_h, :through => [
        :initialize_response, :build_vehicle, :create_vehicle,
        :serialize_response
      ])

      render response
    end

    def show
      response = pipe(params[:id], :through => [
        :initialize_response, :get_vehicle, :serialize_response
      ])

      render response
    end

    def update

    end

    def delete

    end

    private

    def initialize_response(response)
      {:params => response}
    end

    def build_vehicle(response)
      response.tap { |resp|
        resp.merge!(
          :vehicle => Vehicle.new(resp[:params])
        )
      }
    end

    def create_vehicle(response)
      response.tap { |resp|
        begin
          resp[:success] = resp[:vehicle].save!
        rescue => error
          resp.merge!(:error => [400, error])
        end
      }
    end

    def get_vehicle(response)
      response.tap { |resp|
        begin
          resp[:vehicle] = Vehicle.find(resp[:params])
        rescue => error
          resp.merge!(:error => [404, error])
        end
      }
    end

    def get_vehicles(response)
      # TODO: pagination
      response.tap {|resp|
        resp[:vehicle] = Vehicle.all.limit(100)
      }
    end

    def serialize_response(response)
      if response[:error]
        {
          :json => {:errors => [response[:error][1]]},
          :status => response[:error][0]
        }
      elsif response[:success]
        {:status => 201}
      elsif response[:vehicle]
        {
          :json => VehicleSerializer
              .new(response[:vehicle])
              .serializable_hash,
          :status => 200
        }
      else
        {
          :json => {:errors => ['UnhandledExeption']},
          :status => 400
        }
      end
    end

    def vehicle_params
      params.require(:data).permit(:utility_class, :id)
    end
  end
end
