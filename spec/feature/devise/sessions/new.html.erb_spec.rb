# frozen_string_literal: true

RSpec.describe 'devise/sessions/new.html.erb', type: :feature do
  subject(:click_log_in_button) do
    within '.card' do
      click_button I18n.t('devise.sessions.new.log_in')
    end
  end

  let(:user) { create(:user) }

  before { visit new_user_session_path }

  describe 'sign up link' do
    before do
      within '.card' do
        click_link I18n.t('devise.links.sign_up')
      end
    end

    it 'leads to sign up page' do
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  describe 'forgot password link' do
    before { click_link I18n.t('devise.links.forgot_password') }

    it 'leads to forgot password page' do
      expect(page).to have_current_path(new_user_password_path)
    end
  end

  context 'when successfully logged in' do
    before do
      find('input[name="user[email]"]').set(user.email)
      find('input[name="user[password]"]').set(user.password)
      check I18n.t('devise.sessions.new.remember_me')
      click_log_in_button
    end

    it { expect(page).to have_content(user.nickname) }
    it { expect(page).to have_current_path(root_path) }
    it 'sets remember_user_token cookie' do
      cookies = page.driver.browser.manage.all_cookies
      remember_cookie = cookies.find { |cookie| cookie[:name] == 'remember_user_token' }
      expect(remember_cookie).to be_present
    end
  end
end
