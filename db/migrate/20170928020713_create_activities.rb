class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.references :behavior, index: true, foreign_key: true
      t.integer :target_id
      t.string :update_from
      t.string :update_to
      t.json :meta
      t.datetime :created_at
    end
  end
end
