module Errors
  module ErrorsHandler
    def self.included(clazz)
      clazz.class_eval do
      rescue_from ActiveRecord::RecordInvalid, with: :not_create
      end
    end

    private
  #   def record_not_found(_e)
  #     json = Helpers::Render.json(:record_not_found, _e.to_s)
  #     render json: json, status: 404
  #   end
    def not_create(e)
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end
end