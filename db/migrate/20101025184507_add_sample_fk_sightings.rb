class AddSampleFkSightings < ActiveRecord::Migration
  def self.up
    add_column :samples, :sighting_id, :integer
    add_column :samples, :survey_id, :integer
    add_column :samples, :location_1, :string
    add_column :samples, :location_2, :string
    add_column :samples, :location_3, :string
    add_column :samples, :location_4, :string
    add_column :samples, :collector_comments, :text
    add_column :sightings, :distance, :float
    add_column :surveys, :distance, :float
  end

  def self.down
    remove_column :samples, :sighting_id
    remove_column :samples, :survey_id
    remove_column :samples, :location_1
    remove_column :samples, :location_2
    remove_column :samples, :location_3
    remove_column :samples, :location_4
    remove_column :samples, :collector_comments
    remove_column :sightings, :distance
    remove_column :surveys, :distance
  end
end
