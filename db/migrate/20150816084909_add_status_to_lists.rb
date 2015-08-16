class AddStatusToLists < ActiveRecord::Migration
  def change
  	add_column :lists, :status, :string, default: 'active'
  end
end
