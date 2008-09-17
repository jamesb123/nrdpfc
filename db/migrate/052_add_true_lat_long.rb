class AddTrueLatLong < ActiveRecord::Migration
  def self.up
    add_column :samples, :true_latitude, :decimal, :precision => 11, :scale => 9
    add_column :samples, :true_longitude, :decimal, :precision => 11, :scale => 9
  end

  def self.down
    remove_column :samples, :true_latitude
    remove_column :samples, :true_longitude
  end
end
