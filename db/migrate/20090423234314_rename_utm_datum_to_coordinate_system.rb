class RenameUtmDatumToCoordinateSystem < ActiveRecord::Migration
  def self.up
    rename_column :samples, :UTM_datum, :coordinate_system
  end

  def self.down
    rename_column :samples, :coordinate_system, :UTM_datum
  end
end
