# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task routes', type: :routing do
  let(:task) { create :task }

  it 'routes tasks#index' do
    expect(get: '/tasks').to route_to(controller: 'tasks', action: 'index')
  end

  it 'routes tasks#show' do
    expect(get: "/tasks/#{task.id}").to route_to(controller: 'tasks', action: 'show', id: task.id.to_s)
  end

  it 'routes tasks#new' do
    expect(get: 'tasks/new').to route_to(controller: 'tasks', action: 'new')
  end

  it 'routes quizzes#create' do
    expect(post: '/tasks').to route_to(controller: 'tasks', action: 'create')
  end

  it 'routes tasks#update' do
    expect(patch: "/tasks/#{task.id}").to route_to(controller: 'tasks', action: 'update', id: task.id.to_s)
  end

  it 'routes tasks#edit' do
    expect(get: "/tasks/#{task.id}/edit").to route_to(controller: 'tasks', action: 'edit', id: task.id.to_s)
  end

  it 'routes tasks#destroy' do
    expect(delete: "/tasks/#{task.id}").to route_to(controller: 'tasks', action: 'destroy', id: task.id.to_s)
  end
end
