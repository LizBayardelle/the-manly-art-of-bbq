class Joke < ActiveRecord::Base
  belongs_to :user
  acts_as_voteable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
