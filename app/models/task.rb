# frozen_string_literal: true

# This is about Task model
class Task < ApplicationRecord
  validates_uniqueness_of :description, scope: :project_id
  validates :description, :user_id, :project_id, :assigned_by, presence: true
  belongs_to :project
  belongs_to :user
end
