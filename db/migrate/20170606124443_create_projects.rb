class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :user, index: true, foreign_key: true
      t.string :subject
      t.text :description
      t.date :start_on
      t.date :end_on

      t.timestamps
    end
  end
end
