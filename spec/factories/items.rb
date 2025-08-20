FactoryBot.define do
  factory :item do
    title { "テスト商品" }
    description { "テスト商品の説明です" }
    category_id { 2 }
    condition_id { 2 }
    delivery_fee_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 1000 }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test-image.png')),
        filename: 'test-image.png',
        content_type: 'image/png'
      )
    end
  end
end