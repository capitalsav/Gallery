# frozen_string_literal: true

FactoryBot.define do
  factory :image do |factory|
    factory.association :user, factory: :user
    factory.association :category_id, factory: :category
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'fixtures',
                                                   'solnce-kosmos-merkuriy.jpg'),
                                   'image/jpeg')
    end
  end
end
