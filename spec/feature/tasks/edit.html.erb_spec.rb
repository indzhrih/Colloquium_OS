# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/edit.html.erb', type: :feature do
  let(:user) { create :user }
  let(:task) { create :task }

  before do
    sign_in user
    visit edit_task_path(task)
  end

  describe 'page header' do
    it { expect(page).to have_content('Edit Task') }
    it { expect(page).to have_css('h2', text: 'Edit Task') }
  end

  describe 'form fields' do
    it 'has title field with current value' do
      expect(page).to have_field('Title', with: task.title)
    end

    it 'has description field with current value' do
      expect(page).to have_field('Description', with: task.description)
    end

    it 'has status select with current value' do
      expect(page).to have_select('Status', selected: task.status.humanize)
    end

    it 'shows description hint' do
      expect(page).to have_content('Optional description for your task.')
    end
  end

  describe 'form buttons' do
    it { expect(page).to have_button('Update Task') }
    it { expect(page).to have_link('Back', href: tasks_path) }
  end

  describe 'back action link' do
    before { click_link('Back') }

    it { expect(page).to have_current_path(tasks_path) }
  end

  describe 'update action' do
    context 'with valid data' do
      before do
        fill_in 'Title', with: 'Updated Task Title'
        fill_in 'Description', with: 'Updated task description'
        select 'In progress', from: 'Status'
        click_button 'Update Task'
        task.reload
      end

      it 'updates task title' do
        expect(task.title).to eq('Updated Task Title')
      end

      it 'updates task description' do
        expect(task.description).to eq('Updated task description')
      end

      it 'updates task status' do
        expect(task.status).to eq('in_progress')
      end

      it 'redirects to task show page' do
        expect(page).to have_current_path(task_path(task))
      end
    end

    context 'with invalid data' do
      before do
        fill_in 'Title', with: ''
        click_button 'Update Task'
      end

      it 'redirects to show page' do
        expect(page).to have_current_path(task_path(task))
      end
    end
  end

  describe 'status dropdown options' do
    it 'has all status options' do
      expect(page).to have_select('Status', options: ['Todo', 'In progress', 'Done'])
    end
  end
end
