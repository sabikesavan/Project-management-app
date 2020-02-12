# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'should be valid with a email' do
    assert @user.valid?
  end

  test 'test the instance of user' do
    assert_instance_of User, @user
  end

  test 'test invalid without email' do
    @user.email = nil
    refute @user.valid?, 'saved user without a email'
    assert_not_nil @user.errors[:email],
                   'no validation error for email present'
  end

  test 'the email is a string' do
    assert_equal true, @user.email.is_a?(String)
  end

  test 'the user table is not empty' do
    assert_not_equal 0, User.all.count
  end

  test 'to update the user email' do
    @user.update(email: 'sabi@gmail.com')
    assert_equal 'sabi@gmail.com', @user.email
  end

  test 'check duplication' do
    assert_not_equal @user.email, users(:two).email
  end

  test 'user should be unique' do
    duplicate_user = @user.dup
    assert_not duplicate_user.valid?
  end

  test 'belongs to projects' do
    assert_equal 1, @user.projects.size
  end

  test 'belongs to tasks' do
    assert_equal 1, @user.tasks.size
  end
end
