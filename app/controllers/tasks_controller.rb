# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    return render :new, status: :unprocessable_content unless @task.save

    redirect_to @task, notice: 'Task was successfully created.'
  end

  def update
    return render :edit, status: :unprocessable_content unless @task.update(task_params)

    redirect_to @task, notice: 'Task was successfully updated.'
  end

  def destroy
    return render :index, status: :unprocessable_content unless @task.destroy

    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
