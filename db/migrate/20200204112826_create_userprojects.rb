# frozen_string_literal: true

# Userproject table
class CreateUserprojects < ActiveRecord::Migration[6.0]
  def change
    create_table :userprojects do |t|
      t.string :role
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
