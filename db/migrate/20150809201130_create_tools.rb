class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
    	t.string :description, null: false
    	t.belongs_to :goal, index: true
      t.timestamps null: false
    end
  end
end
