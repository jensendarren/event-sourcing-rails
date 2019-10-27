module Commands
  module Meeting
    AcceptSchema = Dry::Validation.Schema do
      required(:user_id).filled
      required(:status).value(eql?: :scheduled)
    end

    class Accept < Command
      def call
        return validate if validate.failure?

        event = publish_event(
          event_type: 'accepted',
          entity_type: 'Meeting',
          entity_id: @entity.id,
          entity_version: @entity.version,
          data: { user_id: @params[:user_id] }
        )

        @entity.handle(event)
        Response.new success: true
      end
    end
  end
end