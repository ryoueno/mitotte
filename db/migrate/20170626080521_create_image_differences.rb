class CreateImageDifferences < ActiveRecord::Migration[5.0]
  def change
    create_table :image_differences do |t|
      t.string :src1, :null => false
      t.string :src2, :null => false
      t.json :result, :null => false
      t.timestamps
    end
  end
end
