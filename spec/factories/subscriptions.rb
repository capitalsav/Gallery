FactoryBot.define do
  factory :subscription do |f|
    f.association :category_id, factory: :category
  end
end
