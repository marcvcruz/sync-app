class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :organizer, index: true, class_name: User
      t.string :description, null: false
      t.date :start_date, null: false
      t.time :start_time
      t.boolean :is_all_day, default: false
      t.text :notes

      t.timestamps null: false
    end
    add_index :events, :start_date
    add_foreign_key :events, :organizer_ids
  end
end
