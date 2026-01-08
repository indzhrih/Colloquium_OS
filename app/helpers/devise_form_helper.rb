# frozen_string_literal: true

module DeviseFormHelper
  def registration_edit_data
    REGISTRATION_EDIT_DATA
  end

  def registration_new_data
    REGISTRATION_NEW_DATA
  end

  def session_new_data
    SESSION_NEW_DATA
  end

  def password_edit_data
    PASSWORD_EDIT_DATA
  end

  def user_avatar(user:, variant: :small)
    user.avatar.attached? ? user.avatar.variant(variant) : 'default_avatar.png'
  end

  private

  REGISTRATION_EDIT_DATA = [
    { field_type: :text_field, field_name: :nickname, autocomplete: 'nickname',
      field_text: 'devise.registrations.edit.nickname' },
    { field_type: :file_field, field_name: :avatar, autocomplete: 'off',
      accept: 'image/png,image/jpeg,image/gif' },
    { field_type: :email_field, field_name: :email, autocomplete: 'email',
      field_text: 'devise.registrations.edit.e-mail' },
    { field_type: :password_field, field_name: :password, autocomplete: 'new-password',
      field_text: 'devise.registrations.edit.password' },
    { field_type: :password_field, field_name: :password_confirmation, autocomplete: 'new-password',
      field_text: 'devise.registrations.edit.confirm_password' },
    { field_type: :password_field, field_name: :current_password, autocomplete: 'new-password',
      field_text: 'devise.registrations.edit.current_password' }
  ].freeze

  REGISTRATION_NEW_DATA = [
    { field_type: :text_field, field_name: :nickname, autocomplete: 'nickname',
      field_text: 'devise.registrations.new.nickname' },
    { field_type: :file_field, field_name: :avatar, autocomplete: 'off',
      accept: 'image/png,image/jpeg,image/gif' },
    { field_type: :email_field, field_name: :email, autocomplete: 'email',
      field_text: 'devise.registrations.new.e-mail' },
    { field_type: :password_field, field_name: :password, autocomplete: 'new-password',
      field_text: 'devise.registrations.new.password' },
    { field_type: :password_field, field_name: :password_confirmation, autocomplete: 'new-password',
      field_text: 'devise.registrations.new.confirm_password' }
  ].freeze

  SESSION_NEW_DATA = [
    { field_type: :email_field, field_name: :email, autocomplete: 'email',
      field_text: 'devise.sessions.new.e-mail' },
    { field_type: :password_field, field_name: :password, autocomplete: 'current-password',
      field_text: 'devise.sessions.new.password' }
  ].freeze

  PASSWORD_EDIT_DATA = [
    { field_type: :password_field, field_name: :password, autocomplete: 'new-password',
      field_text: 'devise.passwords.edit.new_password' },
    { field_type: :password_field, field_name: :password_confirmation, autocomplete: 'new-password',
      field_text: 'devise.passwords.edit.confirm_password' }
  ].freeze
end
