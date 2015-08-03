class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.timestamps null: false
    end
    add_reference :calendars, :user, index: true, foreign_key: true
  end
end
