# frozen_string_literal: true

RSpec.describe 'devise/registrations/new.html.erb', type: :feature do
  subject(:click_sign_up_button) { click_button I18n.t('devise.registrations.new.sign_up') }

  before { visit new_user_registration_path }

  describe 'log in button' do
    before do
      within '.card' do
        click_link I18n.t('devise.links.log_in')
      end
    end

    it 'leads to log in page' do
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'when successfully created user' do
    let(:nickname) { "nick_#{SecureRandom.hex(8)}" }
    let(:email) { "user_#{SecureRandom.hex(8)}@example.com" }
    let(:password) { 'PassworD12' }

    before do
      find("input[name='user[nickname]']").set(nickname)
      find("input[name='user[email]']").set(email)
      find("input[name='user[password]']").set(password)
      find("input[name='user[password_confirmation]']").set(password)
      click_sign_up_button
    end

    it { expect(page).to have_content(nickname) }
    it { expect(page).to have_current_path(root_path) }
  end

  context 'when passwords do not match' do
    before do
      find("input[name='user[nickname]']").set('some_nickname')
      find("input[name='user[email]']").set('email@example.com')
      find("input[name='user[password]']").set('passworD12')
      find("input[name='user[password_confirmation]']").set('another_passworD12')
      click_sign_up_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }

    it {
      expect(page).to have_content(I18n.t('errors.messages.confirmation', resource: 'Password confirmation',
                                          attribute: 'Password'))
    }
  end

  context 'when e-mail is invalid' do
    before do
      find("input[name='user[nickname]']").set('invalid_email')
      find("input[name='user[email]']").set('wrongemail@somemail')
      find("input[name='user[password]']").set('PassworD12')
      find("input[name='user[password_confirmation]']").set('PassworD12')
      click_sign_up_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Email')) }
  end

  context 'when nickname is invalid' do
    before do
      find("input[name='user[nickname]']").set('iinv123.nick+=')
      find("input[name='user[email]']").set('someemail@somemail.com')
      find("input[name='user[password]']").set('PassworD12')
      find("input[name='user[password_confirmation]']").set('PassworD12')
      click_sign_up_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Nickname')) }
  end

  context 'when all data is blank' do
    before do
      find("input[name='user[nickname]']").set('')
      find("input[name='user[email]']").set('')
      find("input[name='user[password]']").set('')
      find("input[name='user[password_confirmation]']").set('')
      click_sign_up_button
    end

    it 'include 8 errors' do
      expect(page).to have_content(I18n.t('errors.messages.not_saved.other', resource: 'user', count: 8))
    end

    describe 'email errors' do
      it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Email')) }
      it { expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Email')) }
    end

    describe 'nickname errors' do
      it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Nickname')) }
      it { expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Nickname')) }
      it { expect(page).to have_content(I18n.t('errors.messages.too_short.other', resource: 'Nickname', count: 3)) }
    end

    describe 'password errors' do
      it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Password')) }
      it { expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Password')) }
      it { expect(page).to have_content(I18n.t('errors.messages.too_short.other', resource: 'Password', count: 8)) }
    end
  end
end
