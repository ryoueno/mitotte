class AddTaskStatusIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :task_status, index: true, foreign_key: true, :after => :project_id
  end
end
