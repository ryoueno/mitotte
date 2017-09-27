class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :subject
      t.text :description
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
