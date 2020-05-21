class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :bartender, dependent: :destroy
  has_many :bookings
  has_many :reviews
  validates :email, uniqueness: true
  
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
