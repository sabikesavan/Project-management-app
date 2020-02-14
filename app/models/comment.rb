class Comment < ApplicationRecord
  validates_uniqueness_of :comment, scope: :task_id
  validates :comment, :user_id, :task_id, presence: true
  belongs_to :user
  belongs_to :task
end
