class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :rsvp, dependent: :destroy
  has_many :attendees, through: :rsvp, source: :user
end
