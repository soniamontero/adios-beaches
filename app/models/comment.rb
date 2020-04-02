class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :done
  has_one :experience, through: :done
end
