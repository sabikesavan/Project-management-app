# frozen_string_literal: true

# This is about Project model
class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :userprojects
  has_many :users, through: :userprojects
  has_many :tasks, dependent: :destroy
end
