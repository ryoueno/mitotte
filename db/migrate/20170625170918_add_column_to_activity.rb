class AddColumnToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :task_id, :string, :after => :behavior
  end
end
