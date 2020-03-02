# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @task = tasks(:one)
    @comment = comments(:one)
  end

  test 'should get new' do
    get new_comment_url(id: @task.id)
    assert_response :success
  end

  test 'should get create' do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { comment: 'comment1',
                                              user_id: @user.id,
                                              task_id: @task.id } }
    end
    assert_redirected_to comment_url(Comment.last)
  end

  test 'should get show' do
    get comment_url(@comment)
    assert_response :success
  end
end
