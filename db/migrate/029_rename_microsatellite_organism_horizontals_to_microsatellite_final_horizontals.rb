class RenameMicrosatelliteOrganismHorizontalsToMicrosatelliteFinalHorizontals < ActiveRecord::Migration
  def self.up
    rename_table :microsatellite_organism_horizontals, :microsatellite_final_horizontals
    select_values("show tables").each{|table_name|
      next unless /microsatellite_organism_horizontals_([0-9]+)/.match(table_name)
      
      project_id = $1
      rename_table "microsatellite_organism_horizontals_#{project_id}", "microsatellite_final_horizontals_#{project_id}"
    }
  end

  def self.down
    rename_table :microsatellite_final_horizontals, :microsatellite_organism_horizontals
    select_values("show tables").each{|table_name|
      next unless /microsatellite_final_horizontals_([0-9]+)/.match(table_name)
      
      project_id = $1
      rename_table "microsatellite_final_horizontals_#{project_id}", "microsatellite_organism_horizontals_#{project_id}"
    }
  end
end
