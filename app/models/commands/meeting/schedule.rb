module Commands
  module Meeting
    ScheduleSchema = Dry::Schema.Params do
      required(:time).value(gt?: Time.now + 5.minutes)
      required(:organizer_id).filled
      required(:invitee_ids).filled { each(:int?) }
    end

    class Schedule < Command
      def call
        # TODO: validate!
        # return validate if validate.failure?

        event = publish_event(
          event_type: 'scheduled',
          entity_type: 'Meeting',
          entity_id: @entity.id,
          entity_version: @entity.version,
          data: {
            time: @params[:time],
            organizer_id: @params[:organizer_id],
            invitee_ids: @params[:invitee_ids]
          }
        )

        @entity.handle(event)
        Response.new success: true, data: { new_meeting: @entity }
      end
    end
  end
end