# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/new.html.erb', type: :feature do
  let(:user) { create :user }

  before do
    sign_in user
    visit new_task_path
  end

  describe 'page header' do
    it { expect(page).to have_content('New Task') }
    it { expect(page).to have_css('h2', text: 'New Task') }
  end

  describe 'form structure' do
    it { expect(page).to have_css('.container') }
    it { expect(page).to have_css('.card') }
    it { expect(page).to have_css('.card-header') }
    it { expect(page).to have_css('.card-body') }
    it { expect(page).to have_css('.card-footer') }
  end

  describe 'form fields' do
    it 'has empty title field' do
      expect(page).to have_field('Title')
    end

    it 'has empty description field' do
      expect(page).to have_field('Description', with: '')
    end

    it 'has default status selected' do
      expect(page).to have_select('Status', selected: 'Todo')
    end

    it 'shows title length requirement' do
      expect(page).to have_content('Title must be between 5 and 30 characters.')
    end

    it 'shows description hint' do
      expect(page).to have_content('Optional description for your task.')
    end

    it 'has required title field' do
      expect(page).to have_css('input[required]')
    end
  end

  describe 'status dropdown' do
    it 'has all available options' do
      expect(page).to have_select('Status',
                                  options: ['Todo', 'In progress', 'Done'])
    end

    it 'defaults to Todo' do
      expect(page).to have_select('Status', selected: 'Todo')
    end
  end

  describe 'form buttons' do
    it { expect(page).to have_button('Create Task') }
    it { expect(page).to have_link('Cancel', href: tasks_path) }
    it { expect(page).to have_link('Back', href: tasks_path) }
  end

  describe 'cancel action link' do
    before { click_link('Cancel') }

    it { expect(page).to have_current_path(tasks_path) }
  end

  describe 'back action link' do
    it 'has back link' do
      expect(page).to have_link('Back', href: tasks_path)
    end

    it 'navigates back when clicked' do
      click_link('Back')
      expect(page).to have_current_path(tasks_path)
    end
  end

  describe 'create action' do
    context 'with valid data' do
      before do
        fill_in 'Title', with: 'New Test Task'
        fill_in 'Description', with: 'This is a test task description'
        select 'Todo', from: 'Status'
        click_button 'Create Task'
      end

      it 'creates a new task' do
        expect(Task.count).to eq(1)
      end

      it 'redirects to task show page' do
        expect(page).to have_current_path(task_path(Task.last))
      end
    end

    context 'when title is empty' do
      before do
        fill_in 'Title', with: ''
        click_button 'Create Task'
      end

      it 'redirects to index page' do
        expect(page).to have_current_path(tasks_path)
      end

      it 'shows specific error for title' do
        expect(page).to have_content("Title can't be blank")
      end
    end

    context 'when title is too short' do
      before do
        fill_in 'Title', with: 'ab'
        click_button 'Create Task'
      end

      it 'redirects to index page' do
        expect(page).to have_current_path(tasks_path)
      end

      it 'shows length error' do
        expect(page).to have_content('Title is too short')
      end
    end

    context 'when title is too long' do
      before do
        fill_in 'Title', with: 'a' * 31
        click_button 'Create Task'
      end

      it 'redirects to index page' do
        expect(page).to have_current_path(tasks_path)
      end

      it 'shows length error' do
        expect(page).to have_content('Title is too long')
      end
    end
  end
end
