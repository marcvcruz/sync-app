class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :organizer, index: true, class_name: User
      t.string :description, null: false
      t.datetime :starting_at, null: false
      t.boolean :is_all_day, default: false
      t.text :notes

      t.timestamps null: false
    end
    add_index :events, :starting_at
    add_foreign_key :events, :users, column: :organizer_id, primary_key: "id"
  end
end
