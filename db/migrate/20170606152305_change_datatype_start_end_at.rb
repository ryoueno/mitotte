class ChangeDatatypeStartEndAt < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :start_at, :date
    change_column :projects, :end_at, :date
  end
end
