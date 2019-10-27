module EventSourced
  class Meeting
    attr_reader :id, :version, :status, :atteendees_count, :time

    def initialize(id)
      @id = id
      @attendees_count = 0
      @version = 0
    end

    def schedule(time:, organizer_id:, invitee_ids:)
      Commands::Meeting::Schedule.call(self, time: time, organizer_id: organizer_id, invitee_ids: invitee_ids)
    end

    def scheduled_handler(event)
      params = event.data.symbolize_keys
      @time = params[:time]
    end

    def accept(user_id:)
      Commands::Meeting::Accept.call(self, user_id: user_id, status: @status)
    end

    def accepted_handler(event)
      @attendees_count += 1
    end

    def reschedule(new_time:)
      Commands::Meeting::Reschedule.call(self, new_time: new_time, status: @status)
    end

    def rescheduled_handler(event)
      params = event.data.symbolize_keys
      @time = params[:new_time]
    end

    def finish
      Commands::Meeting::Finish.call(self, status: @status)
    end

    def finished_handler(event)
      @status = :finished
    end

    def cancel
      Commands::Meeting::Cancel.call(self, status: @status)
    end

    def cancelled_handler(event)
      @status = :cancelled
    end

    def handle(event)
      handler = "#{event.event_type}_handler".to_sym
      if @entity.respond_to? handler
        send(handler, event)
        @version += 1
      end
    end

    class << self
      def get(id)
        entity = new(id)
        load_events_for(entity)
        entity
      end

      def schedule(time:, organizer_id:, invitee_ids:)
        time = time.to_datetime
        EventSourced::Meeting.new(SecureRandom.uuid).schedule(
          time: time,
          organizer_id: organizer_id,
          invitee_ids: invitee_ids
        )
      end

      def load_events_for(entity)
        events = Event.where(entity_type: 'meeting', entity_id: entity.id)
        events.each { |event| entity.handle(event) }
      end
    end
  end
end