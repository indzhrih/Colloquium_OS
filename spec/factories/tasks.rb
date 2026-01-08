# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number: rand(3..30)) }
    description { Faker::Lorem.paragraph }
    status { 'todo' }
  end

  trait :to_do do
    status { 'todo' }
  end

  trait :in_progress do
    status { 'in_progress' }
  end

  trait :done do
    status { 'done' }
  end
end
