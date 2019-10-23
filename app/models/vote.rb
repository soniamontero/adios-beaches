class Vote < ApplicationRecord
  belongs_to :experience
  belongs_to :user
  validates :user, uniqueness: { scope: :experience }


  scope :find_by_experience, -> (user, experience) {where(experience_id: experience.id, user_id: user.id).first}
end
