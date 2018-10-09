class Recipe < ActiveRecord::Base
  belongs_to :user
  acts_as_voteable
  default_scope { order('rankpoints DESC')}
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_one_attached :photo

    def image_filename
      self.photo.filename.to_s if self.photo.attached?
    end

    def image_attached?
      self.photo.attached?
    end
end
