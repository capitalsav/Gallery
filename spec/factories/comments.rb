FactoryBot.define do
  factory :comment do |factory|
    factory.association :image_id, factory: :image
    factory.association :user, factory: :user
    text { Faker::Lorem.sentence }
  end
end
