FactoryBot.define do
  factory :blog_post, class: 'Blog::Post' do
    label { Faker::Lorem.unique.word }
    association :creator
  end

  trait :discarded_blog_post do
    discarded_at { 1.hour.ago }
  end
end
