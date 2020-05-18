class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bartender
  valdiates :rating, presence: true
end
