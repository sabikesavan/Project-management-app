# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:one)
  end

  test 'redirect if not logged in' do
    sign_out :user
    get projects_url
    assert_response :redirect
  end

  test 'should get index' do
    get projects_url
    assert_response :success
  end
end
