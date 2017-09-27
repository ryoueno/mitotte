class ChangeBehaviorToBehaviorId < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :behavior
    remove_column :activities, :task_id
    add_reference :activities, :behavior, index: true, foreign_key: true, :after => :user_id
    add_column :activities, :object_id, :integer, :after => :behavior_id
    add_column :activities, :update_from, :string, :after => :object_id
    add_column :activities, :update_to, :string, :after => :update_from
    add_column :activities, :meta, :json, :after => :update_to
  end
end
