FactoryBot.define do
  factory :item do
    association :user

    name { Faker::Name.initials(number: 2) }
    price { 1000 }
    description { 'テスト' }
    user_id { @user }
    category_id { 1 }
    status_id { 1 }
    payment_id { 1 }
    prefecture_id { 1 }
    day_id { 1 }
  end
end
