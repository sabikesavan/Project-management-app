# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  def setup
    @project = projects(:one)
    @userproject = user_projects(:one)
  end

  test 'viewing the index' do
    sign_in users(:one)
    visit projects_path
    assert_selector 'h1', text: 'Projects'
  end

  test 'select user projects' do
    sign_in users(:one)
    visit projects_path
    click_on @project.name
    assert_selector 'h1', text: 'UserProject'
  end
end
