class RemoveLatestMeasurmentFromKeywords < ActiveRecord::Migration
  def up
    remove_column :keywords, :latest_measurement
  end

  def down
    add_column :keywords, :latest_measurement, :integer
  end
end
