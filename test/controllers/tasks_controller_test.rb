# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = tasks(:one)
    @userproject = userprojects(:one)
  end

  test 'should get index' do
    @user = Userproject.find(@userproject.id)
    get tasks_url(user_id: @user.user_id, project_id: @user.project_id)
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Userproject.count') do
      post tasks_url, params: { task: { description: @task.description,
                                        project_id: @task.project_id,
                                        user_id: @task.user_id,
                                        assigned_by: @task.assigned_by } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test 'should show task' do
    get task_url(@task)
    assert_response :success
  end
end
