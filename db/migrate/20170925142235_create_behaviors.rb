class CreateBehaviors < ActiveRecord::Migration[5.0]
  def change
    create_table :behaviors do |t|
      t.string :name
      t.string :display
      t.string :color_code
      t.integer :priority
    end
  end
end
