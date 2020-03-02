# frozen_string_literal: true

# This is about userprojectscontroller
class UserprojectsController < ApplicationController
  before_action :set_userproject, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    @userprojects = Userproject.where(project_id: params[:id],
                                      user_id: current_user.id)
  end

  def new
    @user = Userproject.find(params[:id])
    if @user.role == 'Admin'
      @role = [['Select', ''], 'Project manager', 'Team lead', 'Developer']
    elsif @user.role == 'Project manager'
      @role = [['Select', ''], 'Team lead', 'Developer']
    elsif @user.role == 'Team lead'
      @role = ['Developer']
    end
    @userproject = Userproject.new(project_id: @user.project_id)
  end

  def create
    @userproject = Userproject.new(userproject_params)
    @role = @userproject.role
    if @userproject.save
      redirect_to @userproject
    else
      redirect_back fallback_location: userprojects_path, notice: 'Give correct values'
    end
  end

  def show; end

  def search
    if params[:user_id] == [''] && params[:description].blank?
      redirect_to request.referrer, alert: 'Empty field!'
    elsif params[:user_id] && params[:description].blank?
      @works = Task.where('project_id = ?', params[:project_id])
      @tasks = @works.where(user_id: params[:user_id])
    elsif params[:description] && params[:user_id] == ['']
      @works = Task.where('project_id = ?', params[:project_id])
      @tasks = @works.where('description ilike ?', "%#{params[:description]}%")
    else
      @works = Task.where('project_id = ? and description ilike ?', params[:project_id], "%#{params[:description]}%")
      @tasks = @works.where(user_id: params[:user_id])
    end

  end

  def destroy
    @user = Userproject.find_by(id: @userproject.id)
    @task = Task.where(user_id: @user.user_id, project_id: @user.project_id)
    @task.destroy_all
    @userproject.destroy
    respond_to do |format|
      format.html { redirect_to userprojects_url(id: @userproject.project_id), notice: 'Userproject was successfully destroyed.' }
    end
  end

  def cancel
    @userproject = Userproject.find(params[:id])
    @cancel_user = Userproject.where(project_id: @userproject.project_id)
  end

  private

  def set_userproject
    @userproject = Userproject.find(params[:id])
  end

  def userproject_params
    params.require(:userproject).permit(:role, :user_id, :project_id)
  end
end
