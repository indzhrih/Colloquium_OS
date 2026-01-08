# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [40, 40]
    attachable.variant :medium, resize_to_limit: [200, 200]
    attachable.variant :large, resize_to_limit: [500, 500]
  end

  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,
            presence: true,
            length: { minimum: 8, maximum: 128 },
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/x },
            if: :password_required?
  validates :nickname,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[\w.-_]+\z/ },
            length: { minimum: 3, maximum: 30 }
  validates :avatar,
            content_type: { in: %w[image/png image/jpeg image/gif], message: 'Wrong image format' },
            size: { less_than: 10.megabytes, message: 'Avatar is too large' }

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
