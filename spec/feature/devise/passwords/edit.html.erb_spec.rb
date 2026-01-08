# frozen_string_literal: true

RSpec.describe 'devise/passwords/new.html.erb', type: :feature do
  subject(:click_change_password_button) { click_button I18n.t('devise.passwords.edit.change_password') }

  let(:user) { create(:user) }
  let(:reset_token) { user.send_reset_password_instructions }

  before { visit edit_user_password_path(reset_password_token: reset_token) }

  context 'when successfully changed password' do
    before do
      find('input[name="user[password]"]').set('new_passworD12')
      find('input[name="user[password_confirmation]"]').set('new_passworD12')
      click_change_password_button
    end

    it { expect(page).to have_content(user.nickname) }
    it { expect(page).to have_current_path(root_path) }
  end

  context 'when incorrect passwords' do
    before do
      find('input[name="user[password]"]').set('new_password')
      find('input[name="user[password_confirmation]"]').set('new_password')
      click_change_password_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Password')) }
  end

  context 'when different passwords' do
    before do
      find('input[name="user[password]"]').set('new_password')
      find('input[name="user[password_confirmation]"]').set('another_new_password')
      click_change_password_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.other', resource: 'user', count: 2)) }

    it {
      expect(page).to have_content(I18n.t('errors.messages.confirmation', resource: 'Password confirmation',
                                                                          attribute: 'Password'))
    }
  end

  context 'when passwords fields are blank' do
    before do
      find('input[name="user[password]"]').set('')
      find('input[name="user[password_confirmation]"]').set('')
      click_change_password_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Password')) }
  end
end
