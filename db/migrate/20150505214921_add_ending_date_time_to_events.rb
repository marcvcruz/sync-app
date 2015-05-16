class AddEndingDateTimeToEvents < ActiveRecord::Migration
  def change
    rename_column :events, :starting_at, :starting_date_time
    add_column :events, :ending_date_time, :datetime, after: :starting_date_time
  end
end
