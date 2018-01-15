FactoryBot.define do
  factory :comment do |factory|
    factory.association :image_id, factory: :image
  end
end
