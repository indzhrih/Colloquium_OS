# frozen_string_literal: true

RSpec.describe 'devise/passwords/new.html.erb', type: :feature do
  subject(:click_send_instructions_button) { click_button I18n.t('devise.passwords.new.send_instructions') }

  let(:user) { build_stubbed(:user) }

  before { visit new_user_password_path }

  context 'when successfully submit password change form' do
    before do
      find('input[name="user[email]"]').set(user.email)
      click_send_instructions_button
    end

    it { expect(page).to have_content(I18n.t('devise.sessions.new.log_in')) }
    it { expect(page).to have_content(I18n.t('devise.sessions.new.e-mail')) }
  end

  context 'when incorrect email' do
    before do
      find('input[name="user[email]"]').set('wrongemail@somemail.com')
      click_send_instructions_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.not_found', resource: 'Email')) }
  end

  context 'when email is blank' do
    before do
      find('input[name="user[email]"]').set('')
      click_send_instructions_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Email')) }
  end
end
