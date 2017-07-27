class CreateUserLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.integer :object_id
      t.integer :behavior
      t.string :update_from
      t.string :update_to
      t.json :meta

      t.datetime :created_at
    end
  end
end
