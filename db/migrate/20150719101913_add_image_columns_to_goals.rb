class AddImageColumnsToGoals < ActiveRecord::Migration
  def up
    add_attachment :goals, :image
  end

  def down
    remove_attachment :goals, :image
  end
end
