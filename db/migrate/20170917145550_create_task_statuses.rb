class CreateTaskStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :task_statuses do |t|
      t.string :name
      t.string :display
    end
  end
end
