class AddLocationMeasurementMethod < ActiveRecord::Migration
  def self.up
    add_column :samples, :location_measurement_method, :string
  end

  def self.down
    remove_column :samples, :location_measurement_method
  end
end
