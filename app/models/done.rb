class Done < ApplicationRecord
  belongs_to :experience
  belongs_to :user
  validates :user, uniqueness: { scope: :experience }
end
