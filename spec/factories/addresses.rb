FactoryBot.define do
  factory :address do
    post_code { "MyString" }
    prefecture_id { 1 }
    municipality { "MyString" }
    house_number { "MyString" }
    building { "MyString" }
    phone { "MyString" }
    purchase { nil }
  end
end
