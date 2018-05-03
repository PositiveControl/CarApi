module CarApiCommon
  module Controllers
    def initialize_response(response)
      {:params => response}
    end

    def build_object(response, klass, klass_sym)
      response.tap { |resp|
        resp.merge!(
          klass_sym => klass.new(resp[:params])
        )
      }
    end

    def update_object(response, klass, klass_sym)
      response.tap { |resp|
        resp[klass_sym].update_attributes(resp[:params])
        resp[klass_sym] = resp[klass_sym].reload
      }
    end

    def save_object(response, klass, klass_sym)
      response.tap { |resp|
        begin
          resp[:success] = resp[klass_sym].save!
        rescue StandardError => error
          resp.merge!(:error => [400, error])
        end
      }
    end

    def destroy_object(response, klass, klass_sym)
      response.tap { |resp|
        resp[:success] = resp[klass_sym].try(:destroy)
      }
    end

    def get_object(response, klass, klass_sym)
      response.tap { |resp|
        begin
          if resp[klass_sym]
            resp[klass_sym] = klass.find(params[:id])
          else
            resp.merge!(klass_sym => klass.find(params[:id]))
          end
        rescue ActiveRecord::RecordNotFound => error
          resp.merge!(:error => [404, error])
        end
      }
    end

    def retrieve_objects(response, klass, klass_sym)
      # TODO: pagination
      response.tap {|resp|
        resp[klass_sym] = klass.all.limit(100)
      }
    end

    def serialize_response(response, klass, klass_sym)
      if response[:error]
        {
          :json => {:errors => [response[:error][1]]},
          :status => response[:error][0]
        }
      elsif response[:success]
        {:status => 201}
      elsif response[klass_sym]
        {
          :json => (klass.to_s + 'Serializer').constantize
            .new(response[klass_sym])
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

    def method_missing(caller, params)
      action, klass_sym = caller
        .to_s
        .singularize
        .split('_')
        .map(&:to_sym)

      klass = klass_sym
        .to_s
        .classify
        .constantize

      case action
        when :build
          build_object(params, klass, klass_sym)
        when :update
          update_object(params, klass, klass_sym)
        when :save
          save_object(params, klass, klass_sym)
        when :destroy
          destroy_object(params, klass, klass_sym)
        when :get
          get_object(params, klass, klass_sym)
        when :retrieve
          retrieve_objects(params, klass, klass_sym)
        when :serialize
          serialize_response(params, klass, klass_sym)
        else
          super
      end
    end
  end
end
