class Done < ApplicationRecord
  has_one :comment, dependent: :destroy
  belongs_to :experience
  belongs_to :user
  validates :user, uniqueness: { scope: :experience }
end
