class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
  		t.datetime :list_date, null: false
    	t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
