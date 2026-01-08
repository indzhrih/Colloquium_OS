# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devise routes', type: :routing do
  it 'routes devise/sessions#new' do
    expect(get: '/users/sign_in').to route_to(controller: 'devise/sessions', action: 'new')
  end

  it 'routes users/registrations#new' do
    expect(get: '/users/sign_up').to route_to(controller: 'users/registrations', action: 'new')
  end

  it 'routes users/registrations#edit' do
    expect(get: '/users/edit').to route_to(controller: 'users/registrations', action: 'edit')
  end

  it 'routes devise/passwords#new' do
    expect(get: '/users/password/new').to route_to(controller: 'devise/passwords', action: 'new')
  end

  it 'routes devise/passwords#edit' do
    expect(get: '/users/password/edit').to route_to(controller: 'devise/passwords', action: 'edit')
  end
end
