# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 5) }

  describe 'GET index' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :index
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'assigns @tasks' do
        expect(assigns(:tasks)).to eq(tasks)
      end
    end

    context 'when user is not authenticated' do
      before { get :index }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET show' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :show, params: { id: tasks.first.id }
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template('show')
      end

      it 'assigns @task' do
        expect(assigns(:task)).to eq(tasks.first)
      end
    end

    context 'when user is not authenticated' do
      before { get :show, params: { id: tasks.first.id } }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'POST create' do
    subject(:create_task) do
      post :create, params: { task: attributes_for(:task) }
    end

    context 'when user is have authenticated' do
      before { sign_in user }

      it 'returns a 302' do
        create_task
        expect(response).to have_http_status(:found)
      end

      it 'redirects to task page' do
        create_task
        expect(response).to redirect_to(Task.last)
      end

      it 'creates the new task record' do
        expect { create_task }.to change(Task, :count).by(1)
      end
    end

    context 'when user is not authenticated' do
      it 'returns a 302' do
        create_task
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        create_task
        expect(response).to redirect_to('/users/sign_in')
      end

      it 'does not create the task record' do
        expect { create_task }.not_to change(Task, :count)
      end
    end
  end

  describe 'GET new' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :new
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template('new')
      end
    end

    context 'when user is not authenticated' do
      before { get :new }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET edit' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :edit, params: { id: tasks.first.id }
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template('edit')
      end

      it 'assigns @task' do
        expect(assigns(:task)).to eq(tasks.first)
      end
    end

    context 'when user is not authenticated' do
      before { get :edit, params: { id: tasks.first.id } }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'PATCH update' do
    subject(:update_task) do
      patch :update, params:
      {
        id: tasks.first.id,
        task: {
          title: 'Updated Title',
          description: 'Updated description',
          status: 'in_progress'
        }
      }
    end

    context 'when user is authenticated' do
      before do
        sign_in user
        update_task
      end

      it 'returns a 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(task_path(tasks.first))
      end
    end

    context 'when user is not authenticated' do
      before { update_task }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'DELETE destroy' do
    subject(:delete_task) { delete :destroy, params: { id: tasks.first.id } }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'returns a redirect' do
        delete_task
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to home page' do
        delete_task
        expect(response).to redirect_to(tasks_path)
      end

      it 'delete task record' do
        expect { delete_task }.to change(Task, :count).by(-1)
      end
    end

    context 'when user is not authenticated' do
      before { delete_task }

      it 'returns a 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to home page' do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
