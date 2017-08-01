class Recipe < ActiveRecord::Base
  belongs_to :user
  acts_as_voteable
  default_scope { order('rankpoints DESC')}
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
