# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "#{Faker::Internet.username(specifier: 3..30).downcase}_#{n}" }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    avatar { nil }

    trait :with_avatar do
      avatar { Rails.root.join('app/assets/images/test_avatar.png').open }
    end
  end
end
