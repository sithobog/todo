class AddTaskToGoal < ActiveRecord::Migration
  def change
  	add_reference :tasks, :goal, index: true, null: true, foreign_key: true
  end
end
