FactoryBot.define do
  factory :purchase_form do
    post_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '横浜市' }
    house_number { '青山1-1-1' }
    building { 'テラスハウス' }
    phone { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
