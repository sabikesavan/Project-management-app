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
      redirect_back fallback_location: userprojects_path, notice: "User has already been taken"
    end
  end

  def show; end

  def destroy
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
