class CreateScreenshots < ActiveRecord::Migration[5.0]
  def change
    create_table :screenshots do |t|
      t.string :uuid, :null => false
      t.string :src, :null => false

      t.timestamps
    end
  end
end
