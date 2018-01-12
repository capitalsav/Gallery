FactoryBot.define do
  factory :subscription do |f|
    f.association :category_id, factory: :category
    f.created_at Date.today
  end
end