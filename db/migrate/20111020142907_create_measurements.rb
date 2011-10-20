class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :keyword_id
      t.integer :value

      t.timestamps
    end
  end
end
