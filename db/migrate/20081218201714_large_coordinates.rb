class LargeCoordinates < ActiveRecord::Migration
  def self.up
    change_column 'samples', 'true_longitude', :decimal, :precision => 18, :scale => 9
    change_column 'samples', 'true_latitude', :decimal, :precision => 18, :scale => 9
  end

  def self.down
  end
end
