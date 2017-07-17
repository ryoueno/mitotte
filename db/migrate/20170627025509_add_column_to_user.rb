class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :keyword, :string
  end
end
