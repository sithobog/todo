class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def up
  	add_attachment :users, :avatar
  end

  def down
  	remove_attachemnt :users, :avatar
  end

end
