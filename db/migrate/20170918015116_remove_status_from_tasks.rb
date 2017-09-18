class RemoveStatusFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :status, :integer
  end
end
