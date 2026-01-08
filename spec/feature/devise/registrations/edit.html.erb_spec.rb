# frozen_string_literal: true

RSpec.describe 'devise/registrations/edit.html.erb', type: :feature do
  subject(:click_update_button) { click_button I18n.t('devise.registrations.edit.update') }

  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit edit_user_registration_path
  end

  describe 'home link' do
    before { click_link I18n.t('devise.registrations.edit.home') }

    it 'leads to home page' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'when successfully updated user' do
    let(:new_nickname) { "new_#{SecureRandom.hex(8)}" }

    before do
      find("input[name='user[nickname]']").set(new_nickname)
      find("input[name='user[email]']").set(user.email)
      find("input[name='user[current_password]']").set(user.password)
      click_update_button
    end

    it { expect(page).to have_content(new_nickname) }
    it { expect(page).to have_current_path(root_path) }
  end

  context 'when successfully deleted user' do
    subject(:click_delete_button) { click_button I18n.t('devise.registrations.edit.delete_account') }

    it 'removes record and shows home page' do
      expect { click_delete_button }.to change(User, :count).by(-1)
    end

    describe 'after deleting account you will be taken to home page' do
      before { click_delete_button }

      it { expect(page).to have_current_path(root_path) }
    end
  end

  context 'when successfully changed password' do
    let(:new_nickname) { "new_#{SecureRandom.hex(8)}" }

    before do
      find("input[name='user[email]']").set(user.email)
      find("input[name='user[password]']").set('new_passworD12')
      find("input[name='user[password_confirmation]']").set('new_passworD12')
      find("input[name='user[current_password]']").set(user.password)
      click_update_button
    end

    it { expect(page).to have_content(user.nickname) }
    it { expect(page).to have_current_path(root_path) }
  end

  context 'when e-mail is wrong' do
    before do
      find("input[name='user[email]']").set('wrongemail@somemail')
      find("input[name='user[current_password]']").set(user.password)
      click_update_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Email')) }
  end

  context 'when nickname is wrong' do
    before do
      find("input[name='user[nickname]']").set('iinv123.nick+=')
      find("input[name='user[email]']").set('someemail@somemail.com')
      find("input[name='user[current_password]']").set(user.password)
      click_update_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Nickname')) }
  end

  context 'when current password is wrong' do
    before do
      find("input[name='user[email]']").set(user.email)
      find("input[name='user[current_password]']").set('wrongpassword')
      click_update_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Password')) }
  end

  context 'when different new passwords' do
    let(:new_nickname) { "new_#{SecureRandom.hex(8)}" }

    before do
      find("input[name='user[email]']").set(user.email)
      find("input[name='user[password]']").set('new_passworD12')
      find("input[name='user[password_confirmation]']").set('another_new_passworD12')
      find("input[name='user[current_password]']").set(user.password)
      click_update_button
    end

    it { expect(page).to have_content(I18n.t('errors.messages.not_saved.one', resource: 'user')) }

    it {
      expect(page).to have_content(I18n.t('errors.messages.confirmation', resource: 'Password confirmation',
                                          attribute: 'Password'))
    }
  end

  context 'when all data is incorrect' do
    before do
      find("input[name='user[nickname]']").set('iinv123.nick+=')
      find("input[name='user[email]']").set('wrong@someemail')
      find("input[name='user[current_password]']").set('wrongpassword')
      click_update_button
    end

    it 'include 3 errors' do
      expect(page).to have_content(I18n.t('errors.messages.not_saved.other', resource: 'user', count: 3))
    end

    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Email')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Nickname')) }
    it { expect(page).to have_content(I18n.t('errors.messages.invalid', resource: 'Password')) }
  end

  context 'when all data is blank' do
    before do
      find("input[name='user[nickname]']").set('')
      find("input[name='user[email]']").set('')
      find("input[name='user[current_password]']").set('')
      click_update_button
    end

    it 'include 6 errors' do
      expect(page).to have_content(I18n.t('errors.messages.not_saved.other', resource: 'user', count: 6))
    end

    it 'password error' do
      expect(page).to have_content(I18n.t('errors.messages.blank', resource: 'Password'))
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
  end
end
