class AddKeywordsToDetections < ActiveRecord::Migration[5.0]
  def change
    add_column :detections, :keywords, :json, :null => false, :after => 'data'
  end
end
