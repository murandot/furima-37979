class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token


  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }, allow_blank: true
  validates :prefecture_id, numericality: {other_than: 1}

  with_options presence: true do
    validates :postal_code, presence: true
    validates :city
    validates :house_number
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end
  
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, allow_blank: true


  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end