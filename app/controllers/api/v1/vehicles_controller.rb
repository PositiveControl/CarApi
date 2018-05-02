module Api::V1
  class VehiclesController < ApplicationController
    include Pipe

    def index
      response = pipe({}, :through => [
        :initialize_response, :get_vehicles, :serialize_response
      ])

      render response
    end

    def create
      response = pipe(vehicle_params.to_h, :through => [
        :initialize_response, :build_vehicle, :save_vehicle,
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
      response  = pipe(vehicle_params, :through => [
        :initialize_response, :get_vehicle, :update_vehicle,
        :serialize_response
      ])

      render response
    end

    def destroy
      response = pipe({}, :through => [
        :initialize_response, :get_vehicle,
        :destroy_vehicle, :serialize_response
      ])

      render response
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

    def update_vehicle(response)
      response.tap { |resp|
        resp[:vehicle].update_attributes(resp[:params])
        resp[:vehicle] = resp[:vehicle].reload
      }
    end

    def save_vehicle(response)
      response.tap { |resp|
        begin
          resp[:success] = resp[:vehicle].save!
        rescue StandardError => error
          resp.merge!(:error => [400, error])
        end
      }
    end

    def destroy_vehicle(response)
      response.tap { |resp|
        resp[:success] = resp[:vehicle].try(:destroy)
      }
    end

    def get_vehicle(response)
      response.tap { |resp|
        begin
          if resp[:vehicle]
            resp[:vehicle] = Vehicle.find(params[:id])
          else
            resp.merge!(:vehicle => Vehicle.find(params[:id]))
          end
        rescue ActiveRecord::RecordNotFound => error
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
      #TODO: move response error handling into a module
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
