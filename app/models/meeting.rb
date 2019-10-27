class Meeting < ApplicationRecord
  has_one :organizer
  has_many :invitees

  class << self
    def scheduled_handler(event)
      params = event.data.symbolize_keys
      create!(
        entity_id: event.entity_id,
        time: params.fetch(:time),
        organizer_id: params.fetch(:organizer_id),
        created_at: event.created_at
      )
      # loop through 'invitee_ids' and update each with this meeting id (or subscribe to it?)
    end

    def accepted_handler(event)
      # no-op
    end

    def recheduled_handler(event)
      meeting = find(event.entity_id)
      params = event.data.symbolize_keys

      meeting.update_attribute(time: params.fetch(:new_time))
    end

    def finished_handler(event)
      meeting = find(event.entity_id)

      meeting.update_attribute(status: :finished)
    end

    def cancelled_handler(event)
      meeting = find(event.entity_id)

      meeting.update_attribute(status: :cancelled)
    end
  end
end