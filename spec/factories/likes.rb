FactoryBot.define do
  factory :like do |factory|
    factory.association :image_id, factory: :image
  end
end
