class CreateTestImages < ActiveRecord::Migration[5.0]
  def change
    create_table :test_images do |t|
      t.string :source, :null => false, :default => ''
      t.boolean :is_valid, :default => true
      t.integer :relevance, :null => true
      t.integer :actual_relevance, :null => true

      t.timestamps
    end
  end
end
