FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    last_name { "山田" }
    first_name { "太郎" }
    last_name_kana { "ヤマダ" }
    first_name_kana { "タロウ" }
    birthday { "2000-01-01" }
  end
end

class User < ApplicationRecord
  validates :password,
            format: {
              with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
              message: 'must include both letters and numbers'
            }

  validates :last_name, 
            format: {
              with: /\A[ぁ-んァ-ン一-龥]+\z/, 
              message: 'is invalid'
            }
  validates :first_name,
            format: {
              with: /\A[ぁ-んァ-ン一-龥]+\z/,
              message: 'is invalid'
            }

  validates :last_name_kana,
            format: {
              with: /\A[ァ-ヶー]+\z/,
              message: 'is invalid'
            }
  validates :first_name_kana,
            format: {
              with: /\A[ァ-ヶー]+\z/,
              message: 'is invalid'
            }

  validates :birthday, presence: true
end