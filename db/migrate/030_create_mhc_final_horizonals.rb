class CreateMhcFinalHorizonals < ActiveRecord::Migration
  def self.up
    create_table :mhc_final_horizonals do |t|
      t.integer :project_id
      t.integer :organism_id
      t.integer :organism_code
      t.integer :allelea
      t.integer :alleleb
      t.integer :extraction_number

      t.timestamps
    end
  end

  def self.down
    drop_table :mhc_final_horizonals
  end
end
