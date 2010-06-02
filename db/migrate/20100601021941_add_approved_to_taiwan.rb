class AddApprovedToTaiwan < ActiveRecord::Migration
  def self.up
    add_column :sightings, :approved, :boolean, :default => true 
    add_column :surveys, :approved, :boolean, :default => true
  end

  def self.down
    remove_column :sightings, :approved
    remove_column :surveys, :approved
  end
end
