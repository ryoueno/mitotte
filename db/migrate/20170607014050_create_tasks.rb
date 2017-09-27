class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :project, index: true, foreign_key: true
      t.references :task_status, index: true, foreign_key: true
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
