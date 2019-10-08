class Experience < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :dones

  validates :name, presence: true, length: { minimum: 5 }
  validates :address, presence: true
  validates :price, numericality: { only_integer: true }

  # PGSEARCH
  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  # ALGOLIA
  # include AlgoliaSearch
  # algoliasearch do
  #   attribute :name, :address, :category_id
  #   # Use all default configuration
  #    # `title` is more important than `{story,comment}_text`, `{story,comment}_text` more than `url`, `url` more than `author`
  #   # btw, do not take into account position in most fields to avoid first word match boost
  # end
end
