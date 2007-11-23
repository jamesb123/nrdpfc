class CreateMicrosatelliteHorizontals < ActiveRecord::Migration
  def self.up
    create_table :microsatellite_horizontals do |t|
      t.integer :project_id
      t.integer :sample_id
      t.integer :organism_code
      t.integer :org_sample
      t.integer :allelea
      t.integer :alleleb
    end
  end

  def self.down
    drop_table :microsatellite_horizontals
  end
end
