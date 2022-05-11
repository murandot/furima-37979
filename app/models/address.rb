class Address < ApplicationRecord
  belongs_to :order

  validates :postal_code,   presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture_id, presence: true, numericality: {other_than: 1}
  validates :city,   presence: true
  validates :house_number,   presence: true
  validates :building_name,   presence: true
  validates :phone_number,   presence: true, format: { with: /\A\d{10,11}\z/ }

end
