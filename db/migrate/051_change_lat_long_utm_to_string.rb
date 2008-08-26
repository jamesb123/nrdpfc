class ChangeLatLongUtmToString < ActiveRecord::Migration
  def self.up
    change_column :samples, :latitude, :string
    change_column :samples, :longitude, :string
  end

  def self.down
    change_column :samples, :latitude, :float
    change_column :samples, :longitude, :float
  end
end
