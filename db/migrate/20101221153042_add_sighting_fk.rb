class AddSightingFk < ActiveRecord::Migration
  def self.up
    add_column :sightings, :sample_id, :integer
    add_column :surveys, :sample_id, :integer
  end

  def self.down
    remove_column :sightings, :sample_id
    remove_column :surveys, :sample_id
  end
end
