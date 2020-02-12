# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
  end

  test 'viewing the index' do
    visit users_path
    assert_selector 'h1', text: 'Home'
  end

  test 'can create user' do
    visit users_path
    click_on 'Signup'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    visit users_path
  end

  test 'can login user' do
    visit users_path
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    assert_text 'Signed in successfully.'
  end

  test 'can access projects' do
    sign_in users(:one)
    visit users_path
    click_on 'Project'
    visit projects_path
  end

  test 'can logout' do
    sign_in users(:one)
    visit users_path
    click_on 'Logout'
    assert_text 'Signed out successfully.'
  end
end
