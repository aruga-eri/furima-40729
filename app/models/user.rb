class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  # has_many :purchases
  # has_many :comments

  with_options presence: true do
    validates :nickname
    validates :password, format: {
      with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
      message: 'must include both letters and numbers'
    }

    validates :last_name, format: {
      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
      message: 'is invalid'
    }
    validates :first_name, format: {
      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
      message: 'is invalid'
    }

    validates :last_name_kana, format: {
      with: /\A[ァ-ヶー]+\z/,
      message: 'is invalid'
    }
    validates :first_name_kana, format: {
      with: /\A[ァ-ヶー]+\z/,
      message: 'is invalid'
    }

    validates :birthday
  end
end
