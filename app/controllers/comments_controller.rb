class CommentsController < ApplicationController
  def index
    @userproject = Userproject.find(params[:id])
    @comments = Comment.where(user_id: @userproject.user_id)
  end

  def new
    @task = Task.find(params[:id])
    @comment = Comment.new(user_id: @task.assigned_by, task_id: @task.id)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment
    else
      render :action => 'new'
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :task_id)
  end
end
