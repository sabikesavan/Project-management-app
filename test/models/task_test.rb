# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
  end

  test 'test the instance of task' do
    assert_instance_of Task, @task
  end

  test 'test invalid without description' do
    @task.description = nil
    refute @task.valid?, 'saved task without a description'
    assert_not_nil @task.errors[:description],
                   'no validation error for description present'
  end

  test 'test invalid without user' do
    @task.user = nil
    refute @task.valid?, 'saved task without a user'
    assert_not_nil @task.errors[:user],
                   'no validation error for user present'
  end

  test 'test invalid without project' do
    @task.project = nil
    refute @task.valid?, 'saved user without a project'
    assert_not_nil @task.errors[:project],
                   'no validation error for project present'
  end

  test 'the description is a string' do
    assert_equal true, @task.description.is_a?(String)
  end

  test 'the task table is not empty' do
    assert_not_equal 0, Task.all.count
  end

  test 'to update the task description' do
    @task.update(description: 'task1')
    assert_equal 'task1', @task.description
  end

  test 'check duplication' do
    assert_not_equal @task.description, tasks(:two).description
  end

  test 'task should be unique' do
    duplicate_task = @task.dup
    assert_not duplicate_task.valid?
  end
end
