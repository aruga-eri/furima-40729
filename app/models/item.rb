class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # テーブルとのアソシエーション
  belongs_to :user
  has_one    :purchase
  has_many   :comments

  # アクティブハッシュとのアソシエーション
  belongs_to :category
  belongs_to :situation
  belongs_to :load
  belongs_to :prefecture
  belongs_to :delivery

  # アクティブストレージとのアソシエーション
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :explanation
    validates :category_id
    validates :situation_id
    validates :load_id
    validates :prefecture_id
    validates :delivery_id
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
  end

  # ジャンルの選択が「---」の時は保存不可
  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :situation_id
    validates :load_id
    validates :prefecture_id
    validates :delivery_id
  end
end
