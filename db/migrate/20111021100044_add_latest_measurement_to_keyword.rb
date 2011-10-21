class AddLatestMeasurementToKeyword < ActiveRecord::Migration
  def change
    add_column :keywords, :latest_measurement, :integer
  end
end
