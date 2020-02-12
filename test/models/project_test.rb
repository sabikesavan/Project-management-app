# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @project = projects(:one)
  end

  test 'should be valid with a name' do
    assert @project.valid?
  end

  test 'test the instance of project' do
    assert_instance_of Project, @project
  end

  test 'test invalid without name' do
    @project.name = nil
    refute @project.valid?, 'saved project without a name'
    assert_not_nil @project.errors[:name],
                   'no validation error for name present'
  end

  test 'the project is a string' do
    assert_equal true, @project.name.is_a?(String)
  end

  test 'the project table is not empty' do
    assert_not_equal 0, Project.all.count
  end

  test 'to update the project name' do
    @project.update(name: 'project')
    assert_equal 'project', @project.name
  end

  test 'check duplication' do
    assert_not_equal @project.name, projects(:two).name
  end

  test 'project should be unique' do
    duplicate_project = @project.dup
    assert_not duplicate_project.valid?
  end

  test 'belongs to' do
    assert_equal 1, @project.users.size
  end
end
