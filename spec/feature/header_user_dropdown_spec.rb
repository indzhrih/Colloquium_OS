# frozen_string_literal: true

RSpec.describe 'user dropdown after authetication', type: :feature do
  context 'when include default avatar' do
    let(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
      click_button user.nickname
    end

    describe 'include dropdown options' do
      it { expect(page).to have_content('Settings') }
      it { expect(page).to have_content('Hello') }
      it { expect(page).to have_content(user.nickname) }
      it { expect(page).to have_css('img[src*="default_avatar"]') }
    end

    describe 'settings button leads to edit profile page' do
      before { click_link 'Settings' }

      it { expect(page).to have_content(I18n.t('devise.registrations.edit.delete_account')) }
      it { expect(page).to have_content(I18n.t('devise.registrations.edit.home')) }
    end

    describe 'log out button' do
      before { click_button 'Log out' }

      it { expect(page).to have_content('Log in') }
      it { expect(page).to have_content('Sign up') }
    end
  end
end
