class Event < ApplicationRecord
  def self.create_and_broadcast(params)
    self.create!(params)
    # TODO use wisper to braodcast!
  end
end
