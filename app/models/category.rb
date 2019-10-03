class Category < ApplicationRecord
  enum name: ["food", "stays", "nature", "arts", "nightlife", "sports", "workshops"]
end
