class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :term, null: false

      t.timestamps null: false
    end
  end
end
