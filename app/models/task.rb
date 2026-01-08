# frozen_string_literal: true

class Task < ApplicationRecord
  enum :status, { todo: 0, in_progress: 1, done: 2 }, default: :todo

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
