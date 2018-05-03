module Api::V1
  class MakesController < ApplicationController
    include Pipe

    def index
      response = pipe({}, :through => [
        :initialize_response, :get_makes, :serialize_response
      ])

      render response
    end

    def create
      response = pipe(make_params.to_h, :through => [
        :initialize_response, :build_make, :save_make,
        :serialize_response
      ])

      render response
    end

    def show
      response = pipe(params[:id], :through => [
        :initialize_response, :get_make, :serialize_response
      ])

      render response
    end

    def update
      response  = pipe(make_params, :through => [
        :initialize_response, :get_make, :update_make,
        :serialize_response
      ])

      render response
    end

    def destroy
      response = pipe({}, :through => [
        :initialize_response, :get_make,
        :destroy_make, :serialize_response
      ])

      render response
    end

    private

    def initialize_response(response)
      {:params => response}
    end

    def build_make(response)
      response.tap { |resp|
        resp.merge!(
          :make => Make.new(resp[:params])
        )
      }
    end

    def update_make(response)
      response.tap { |resp|
        resp[:make].update_attributes(resp[:params])
        resp[:make] = resp[:make].reload
      }
    end

    def save_make(response)
      response.tap { |resp|
        begin
          resp[:success] = resp[:make].save!
        rescue StandardError => error
          resp.merge!(:error => [400, error])
        end
      }
    end

    def destroy_make(response)
      response.tap { |resp|
        resp[:success] = resp[:make].try(:destroy)
      }
    end

    def get_make(response)
      response.tap { |resp|
        begin
          if resp[:make]
            resp[:make] = Make.find(params[:id])
          else
            resp.merge!(:make => Make.find(params[:id]))
          end
        rescue ActiveRecord::RecordNotFound => error
          resp.merge!(:error => [404, error])
        end
      }
    end

    def get_makes(response)
      response.tap {|resp|
        resp[:make] = Make.all.limit(100)
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
      elsif response[:make]
        {
          :json => MakeSerializer
            .new(response[:make])
            .serializable_hash,
          :status => 200
        }
      else
        {
          :json => {:errors => ['UnhandledException']},
          :status => 400
        }
      end
    end

    def make_params
      params.require(:data).permit(:brand, :id)
    end
  end
end
