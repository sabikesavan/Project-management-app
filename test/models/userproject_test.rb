# frozen_string_literal: true

require 'test_helper'

class UserprojectTest < ActiveSupport::TestCase
  def setup
    @userproject = userprojects(:one)
  end

  test 'should be valid' do
    assert @userproject.valid?
  end

  test 'test the instance of userproject' do
    assert_instance_of Userproject, @userproject
  end

  test 'test invalid without role' do
    @userproject.role = nil
    refute @userproject.valid?, 'saved userproject without a role'
    assert_not_nil @userproject.errors[:role],
                   'no validation error for role present'
  end

  test 'test invalid without user' do
    @userproject.user = nil
    refute @userproject.valid?, 'saved userproject without a role'
    assert_not_nil @userproject.errors[:user],
                   'no validation error for role present'
  end

  test 'test invalid without project' do
    @userproject.project = nil
    refute @userproject.valid?, 'saved userproject without a role'
    assert_not_nil @userproject.errors[:project],
                   'no validation error for role present'
  end

  test 'the role is a string' do
    assert_equal true, @userproject.role.is_a?(String)
  end

  test 'the userproject table is not empty' do
    assert_not_equal 0, Userproject.all.count
  end

  test 'to update the user role' do
    @userproject.update(role: 'Team Lead')
    assert_equal 'Team Lead', @userproject.role
  end

  test 'check duplication' do
    assert_not_equal @userproject, userprojects(:two)
  end

  test 'user should be unique' do
    duplicate_user = @userproject.dup
    assert_not duplicate_user.valid?
  end
end
