class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bartender
  validates :rating, presence: true
end
