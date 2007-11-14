class ChangeTypeLatLong < ActiveRecord::Migration
  def self.up
    remove_column :samples, :type_lat_long
    add_column :samples, :type_lat_long, :string
  end

  def self.down
    remove_column :samples, :type_lat_long
    add_column :samples, :type_lat_long, :text
  end
end
