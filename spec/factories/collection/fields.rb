FactoryBot.define do
  factory :collection_field, class: 'Collection::Field' do
    label { Faker::Lorem.unique.word }
    field_type { 'text' }
    association :creator
    association :item
  end

  trait :discarded_field do
    discarded_at { 1.hour.ago }
  end
end
