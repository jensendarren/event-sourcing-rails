module Commands
  class Command
    class Response
      attr_reader :success, :errors, :data

      def initialize(success:, errors: nil, data: nil)
        @success = success
        @errors = errors
        @data = data
      end

      def failure?
        !success
      end

      def success?
        success
      end
    end

    def self.call(entity, params)
      new(entity, params).call
    end

    def initialize(entity, params)
      @entity = entity
      @params = params
      @validator = schema.call(params)
    end

    def publish_event(params)
      Event.create_and_broadcast(params)
    end

    def validate
      @validator.success? ? Response.new(success: true) : Response.new(success: false, errors: @validator.errors)
    end

    def schema
      "#{self.class.name}Schema".constantize
    end
  end
end