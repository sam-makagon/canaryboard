class AddStoppedAtDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :stopped_at, :datetime
  end
end
