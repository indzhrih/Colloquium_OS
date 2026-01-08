# frozen_string_literal: true

RSpec.describe 'layouts/header/_header.html.erb', type: :feature do
  let(:user) { create(:user) }

  before { visit root_path }

  describe 'when user IS NOT authenticated' do
    it 'include sign up button' do
      expect(page).to have_content('Sign up')
    end

    it 'include log in button' do
      expect(page).to have_content('Log in')
    end

    describe 'brand title leads to home page' do
      before { click_link 'Tasks' }

      it { expect(page).to have_current_path(root_path) }
    end

    describe 'log in button leads to log in page' do
      before { click_link 'Log in' }

      it { expect(page).to have_content('Log in') }
      it { expect(page).to have_content(I18n.t('devise.sessions.new.password')) }
    end

    describe 'sign up button leads to sign up page' do
      before { click_link 'Sign up' }

      it { expect(page).to have_content('Sign up') }
      it { expect(page).to have_content(I18n.t('devise.registrations.new.password')) }
    end
  end

  describe 'when user IS authenticated' do
    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it 'include user nickname' do
      expect(page).to have_content(user.nickname)
    end
  end
end
