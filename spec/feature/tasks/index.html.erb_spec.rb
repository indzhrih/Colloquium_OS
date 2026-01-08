# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/index.html.erb', type: :feature do
  let(:user) { create :user }

  before { sign_in user }

  context 'when tasks were created' do
    let!(:task) { create(:task) }

    before { visit tasks_path }

    it "include 'Tasks' label" do
      expect(page).to have_content('Tasks')
    end

    it 'include new task button' do
      expect(page).to have_link('New Task', href: new_task_path)
    end

    describe 'table first row' do
      it { expect(page).to have_content('Title') }
      it { expect(page).to have_content('Status') }
      it { expect(page).to have_content('Actions') }
      it { expect(page).to have_content('Created') }
    end

    describe 'task fields' do
      it { expect(page).to have_content(task.title) }
      it { expect(page).to have_content(task.status.humanize) }
      it { expect(page).to have_content(I18n.l(task.created_at, format: :short)) }
    end

    describe 'actions' do
      it { expect(page).to have_link('Show', href: task_path(task)) }
      it { expect(page).to have_link('Edit', href: edit_task_path(task)) }
    end

    describe 'show action link' do
      before { click_link 'Show' }

      it { expect(page).to have_current_path(task_path(task)) }
    end

    describe 'edit action link' do
      before { click_link 'Edit' }

      it { expect(page).to have_current_path(edit_task_path(task)) }
    end
  end

  context 'when NO tasks were created' do
    before { visit tasks_path }

    it { expect(page).to have_content('No tasks yet. Create your first task!') }
  end
end
