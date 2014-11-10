class AddMsKeepThis < ActiveRecord::Migration
  def self.up
    add_column :microsatellites, :FinalSampleResult, :boolean
    rename_column :samples, :photo_id, :sighting_ident
  end

  def self.down
    remove_colun :microsatellites, :FinalSampleResult
    rename_column :samples, :sighting_ident, :photo_id
  end
end
