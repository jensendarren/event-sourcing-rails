class Invitee < ApplicationRecord
  belongs_to :meeting, optional: true
end