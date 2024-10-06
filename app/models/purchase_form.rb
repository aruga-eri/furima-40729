class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipality, :house_number, :building, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :municipality
    validates :house_number
    validates :phone, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid' }
    validates :token
  end

  def save
    user_id_value = user_id
    item_id_value = item_id
    purchase = Purchase.create(user_id: user_id_value, item_id: item_id_value)

    post_code_value = post_code
    prefecture_id_value = prefecture_id
    municipality_value = municipality
    house_number_value = house_number
    building_value = building
    phone_value = phone

    Address.create(
      purchase_id: purchase.id,
      post_code: post_code_value,
      prefecture_id: prefecture_id_value,
      municipality: municipality_value,
      house_number: house_number_value,
      building: building_value,
      phone: phone_value
    )
  end
end
