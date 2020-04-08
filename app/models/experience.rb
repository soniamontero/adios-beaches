class Experience < ApplicationRecord
  belongs_to :user
  has_many :experience_categories, inverse_of: :experience
  accepts_nested_attributes_for :experience_categories
  has_many :categories, through: :experience_categories
  has_many :dones
  has_many :votes
  has_many :favorites
  has_many :comments, through: :dones

  enum price_range: [:low, :medium, :high]

  validates :name, presence: true, length: { minimum: 5, maximum: 45 }
  validates :address, presence: true
  validates :price, numericality: { only_integer: true }, allow_nil: true
  validates :price_range, presence: true, inclusion: { in: price_ranges.keys }
  validates :details, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_create :add_owner_as_done

  mount_uploader :photo, PhotoUploader

  # PGSEARCH
  include PgSearch::Model
  pg_search_scope :search_by_name_and_address_and_category,
    against: [ :name, :address ],
    associated_against: {
      category: :name
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def self.sorted_by_higher_votes
    Experience.select("experiences.*, COUNT(votes.id) vote_count")
    .left_joins(:votes)
    .group("experiences.id")
    .order("vote_count DESC")
  end

  def add_owner_as_done
    Done.create!(experience_id: self.id, user_id: self.user_id)
  end

  def total_votes
    if self.votes.empty?
      0
    else
      self.votes.pluck(:value).sum
    end
  end

  def total_votes_state
    if self.total_votes == 0
      state = "neutral"
      return state.html_safe
    elsif self.total_votes.negative?
      state = "deactivated"
      return state.html_safe
    else
      state = "activated"
      return state.html_safe
    end
  end

  def total_dones
    if self.dones.length == 0
      "None one has been there yet."
    else
      return User.where(id: self.dones.pluck(:user_id))
    end
  end

  def price_range_to_icon
    if self.price_range == 'high'
      string = '<i class="fas fa-euro-sign"></i>' * 3
      string.html_safe
    elsif self.price_range == 'medium'
      string = '<i class="fas fa-euro-sign"></i>' * 2
      string.html_safe
    else
      string = '<i class="fas fa-euro-sign"></i>'
      string.html_safe
    end
  end


end
