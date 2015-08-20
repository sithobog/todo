class AddConclusionToGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :conclusion, :string, null: true
  end
end
