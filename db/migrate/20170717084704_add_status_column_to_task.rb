class AddStatusColumnToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :status, :integer, :after => :description, :default => 0, :null => false
  end
end
