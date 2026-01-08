# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'MyString' }
    description { 'MyText' }
    status { 1 }
  end
end
