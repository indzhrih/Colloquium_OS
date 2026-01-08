# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/show.html.erb', type: :feature do
  let(:user) { create :user }
  let(:task) { create :task }

  before do
    sign_in user
    visit task_path(task)
  end

  describe 'task info' do
    it { expect(page).to have_content('Title') }
    it { expect(page).to have_content(task.title) }

    it { expect(page).to have_content('Description') }
    it { expect(page).to have_content(task.description) }

    it { expect(page).to have_content('Status') }
    it { expect(page).to have_content(task.status.humanize) }

    it { expect(page).to have_content('Created') }
    it { expect(page).to have_content(task.created_at.strftime('%B %d, %Y %H:%M')) }

    it { expect(page).to have_content('Update') }
    it { expect(page).to have_content(task.updated_at.strftime('%B %d, %Y %H:%M')) }
  end

  describe 'actions' do
    it { expect(page).to have_link('Edit', href: edit_task_path(task)) }
    it { expect(page).to have_link('Back', href: tasks_path) }
    it { expect(page).to have_button('Delete') }
  end

  describe 'edit action link' do
    before { click_link('Edit') }

    it { expect(page).to have_current_path(edit_task_path(task)) }
  end

  describe 'back action link' do
    before { click_link('Back') }

    it { expect(page).to have_current_path(tasks_path) }
  end

  describe 'delete action button' do
    subject(:delete_task) { click_button 'Delete' }

    it 'delete Task record' do
      expect { delete_task }.to change(Task, :count).by(-1)
    end

    it 'redirects to tasks path' do
      delete_task
      expect(page).to have_current_path(tasks_path)
    end
  end
end
