# frozen_string_literal: true

# This is about User model
class User < ApplicationRecord
  has_many :userprojects
  has_many :projects, through: :userprojects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
