# frozen_string_literal: true

require 'application_system_test_case'

class UserprojectsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @project = projects(:one)
    @userproject = userprojects(:one)
  end

  test 'visiting the index' do
    sign_in users(:one)
    visit userprojects_url
    assert_selector 'h1', text: 'Userprojects'
  end

  test 'creating a Userproject' do
    visit userprojects_url
    click_on 'New Userproject'

    fill_in 'Project', with: @userproject.project_id
    fill_in 'Role', with: @userproject.role
    fill_in 'User', with: @userproject.user_id
    click_on 'Create Userproject'

    assert_text 'Userproject was successfully created'
    click_on 'Back'
  end

  test 'updating a Userproject' do
    visit userprojects_url
    click_on 'Edit', match: :first

    fill_in 'Project', with: @userproject.project_id
    fill_in 'Role', with: @userproject.role
    fill_in 'User', with: @userproject.user_id
    click_on 'Update Userproject'

    assert_text 'Userproject was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Userproject' do
    visit userprojects_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Userproject was successfully destroyed'
  end
end
