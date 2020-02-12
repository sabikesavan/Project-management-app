# frozen_string_literal: true

# Task table
class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.text :description
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.bigint :assigned_by

      t.timestamps
    end
  end
end
