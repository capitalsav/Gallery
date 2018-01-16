FactoryBot.define do
  factory :image do |factory|
    factory.association :user_id, factory: :user
    factory.association :category_id, factory: :category
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'solnce-kosmos-merkuriy.jpg'), 'image/jpeg') }
  end
end
