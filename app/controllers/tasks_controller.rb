# frozen_string_literal: true

# This is about Taskscontroller
class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @userproject = Userproject.find(params[:id])
    @tasks = Task.where(user_id: @userproject.user_id,
                        project_id: @userproject.project_id)
  end

  def new
    @userproject = Userproject.find(params[:id])
    @users = Userproject.where(project_id: @userproject.project_id)
    @user_id = []
    @users.each do |user|
      @user_id << user.user_id
    end
    @task = Task.new(project_id: @userproject.project_id,
                     assigned_by: @userproject.user_id)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      redirect_back fallback_location: root_path, notice: "Give correct values"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def search
    if params[:task][:user_id] == [""] && params[:description].blank?
      redirect_to request.referrer, alert: "Empty field!"
    elsif params[:task][:user_id] && params[:description].blank?
      @works = Task.where("project_id = ?", params[:project_id])
      @tasks = @works.where(user_id: params[:task][:user_id])
    elsif params[:description] && params[:task][:user_id] == [""]
      @tasks = Task.where("description ilike ?", "%#{params[:description]}%")
    else
      @works = Task.where("project_id = ? and description ilike ?", params[:project_id], params[:description])
      @tasks = @works.where(user_id: params[:task][:user_id])
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :project_id, :user_id,
                                 :assigned_by, :user_id[])
  end
end
