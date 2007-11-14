class CreateMicrosatelliteHorizontals < ActiveRecord::Migration
  def self.up
    create_table :microsatellite_horizontals do |t|
      integer :project_id
      integer :sample_id
      integer :organism_code
      integer :org_sample
      integer :allelea
      integer :alleleb
    end
  end

  def self.down
    drop_table :microsatellite_horizontals
  end
end
