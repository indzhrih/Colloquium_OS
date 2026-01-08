# frozen_string_literal: true

module FlashHelper
  def flash_type(type:)
    {
      success: 'alert-success',
      warning: 'alert-warning',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }.fetch(type.to_sym, 'alert-info')
  end
end
