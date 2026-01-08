# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname avatar])
    end
  end
end
