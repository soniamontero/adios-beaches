class Experience < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :dones

  enum price_range: [:low, :medium, :high]

  validates :name, presence: true, length: { minimum: 5 }
  validates :address, presence: true
  validates :price, numericality: { only_integer: true }
  validates :price_range, presence: true, inclusion: { in: price_ranges.keys }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  mount_uploader :photo, PhotoUploader

  # PGSEARCH
  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
