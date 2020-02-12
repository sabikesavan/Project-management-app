# frozen_string_literal: true

# This is about Userproject model
class Userproject < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :project_id
  validates :role, :user_id, :project_id, presence: true
  belongs_to :user
  belongs_to :project
end
