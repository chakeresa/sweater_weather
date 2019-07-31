FactoryBot.define do
  factory :image do
    sequence(:title) { |n| "image_title_#{n}" }
    sequence(:url) { |n| "image_url_#{n}.jpg" }
  end
end
