FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    last_name { "山田" }
    first_name { "陸太郎" }
    last_name_kana { "ヤマダ" }
    first_name_kana { "リクタロウリクタロウ" }
    birthday { "2000-01-01" }
  end
end
