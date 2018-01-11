FactoryBot.define do
  factory :category do |factory|
    name { Faker::Name.name }
  end
end