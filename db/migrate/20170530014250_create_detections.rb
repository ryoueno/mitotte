class CreateDetections < ActiveRecord::Migration[5.0]
  def change
    create_table :detections do |t|
      t.string :screenshot_id, :null => false
      t.string :mode, :null => false
      t.json :data, :null => false
      t.json :keywords, :null => false

      t.timestamps
    end
  end
end
