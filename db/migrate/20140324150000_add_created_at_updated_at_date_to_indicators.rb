class AddCreatedAtUpdatedAtDateToIndicators < ActiveRecord::Migration
  def change
    change_table(:indicators) { |t| t.timestamps }
  end
end
