class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
    	t.text :body, null: false
    	t.datetime :day, null: false
    	t.references :user
      t.timestamps null: false
    end
  end
end
