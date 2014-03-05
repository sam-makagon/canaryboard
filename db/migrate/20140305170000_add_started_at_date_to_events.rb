class AddStartedAtDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :started_at, :datetime
  end
end
