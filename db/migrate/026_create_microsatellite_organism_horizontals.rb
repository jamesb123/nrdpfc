class CreateMicrosatelliteOrganismHorizontals < ActiveRecord::Migration
  def self.up
    create_table :microsatellite_organism_horizontals do |t|
      integer :project_id
      integer :organism_id
      integer :organism_code
      integer :allelea
      integer :alleleb
    end
  end

  def self.down
    drop_table :microsatellite_organism_horizontals
  end
end
