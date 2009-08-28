class AddMicrosatelliteIndexes < ActiveRecord::Migration
  def self.up
    add_index :microsatellites, :gel
    add_index :microsatellites, :well
    add_index :microsatellites, :locu_id
  end

  def self.down
    remove_index :microsatellites, :gel
    remove_index :microsatellites, :well
    remove_index :microsatellites, :locu_id
  end
end
