# frozen_string_literal: true

# This is about Projectscontroller
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @userproject = current_user.userprojects
  end
end
