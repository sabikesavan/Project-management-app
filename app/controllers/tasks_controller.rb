# frozen_string_literal: true

# This is about Taskscontroller
class TasksController < ApplicationController
  def index
    @userproject = Userproject.find(params[:id])
    @tasks = Task.where(user_id: @userproject.user_id,
                        project_id: @userproject.project_id)
  end

  def new
    @userproject = Userproject.find(params[:id])
    @users = Userproject.where(project_id: @userproject.project_id)
    @user = []
    @users.each do |user|
      @user << user.user_id
    end
    @task = Task.new(project_id: @userproject.project_id,
                     assigned_by: @userproject.user_id)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render action: 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:description, :project_id, :user_id,
                                 :assigned_by)
  end
end
