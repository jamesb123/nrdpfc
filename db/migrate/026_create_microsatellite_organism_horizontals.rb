class CreateMicrosatelliteOrganismHorizontals < ActiveRecord::Migration
  def self.up
    create_table :microsatellite_organism_horizontals do |t|
      t.integer :project_id
      t.integer :organism_id
      t.integer :organism_code
      t.integer :allelea
      t.integer :alleleb
    end
  end

  def self.down
    drop_table :microsatellite_organism_horizontals
  end
end
