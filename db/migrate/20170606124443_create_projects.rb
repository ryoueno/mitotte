class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :subject
      t.text :description
      t.date :start_on
      t.date :end_on

      t.timestamps
    end
  end
end
