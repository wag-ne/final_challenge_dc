class Address < ApplicationRecord
  belongs_to :order

  validates :order,
  :country,
  :state,
  :city,
  :district,
  :street,
  :latitude,
  :longitude, presence: true
end
