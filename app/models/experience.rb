class Experience < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true, length: { minimum: 5 }
  validates :address, presence: true
  validates :price, numericality: { only_integer: true }

end
