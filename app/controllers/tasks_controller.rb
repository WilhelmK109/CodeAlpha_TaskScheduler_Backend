class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
    render json: @tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
    render json: @task
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      render json: @task
    else
      render json: { errors: @task.errors.full_message }, status: :unprocessable_entity
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_message }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline)
  end
end
