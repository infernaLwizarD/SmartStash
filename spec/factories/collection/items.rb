FactoryBot.define do
  factory :collection_item, class: 'Collection::Item' do
    label { Faker::Lorem.unique.word }
    association :creator
  end

  trait :discarded_collection_item do
    discarded_at { 1.hour.ago }
  end
end
