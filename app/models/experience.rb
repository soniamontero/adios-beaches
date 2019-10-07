class Experience < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :dones

  validates :name, presence: true, length: { minimum: 5 }
  validates :address, presence: true
  validates :price, numericality: { only_integer: true }

  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
