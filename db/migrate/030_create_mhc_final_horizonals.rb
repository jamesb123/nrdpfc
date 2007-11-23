class CreateMhcFinalHorizonals < ActiveRecord::Migration
  def self.up
    create_table :mhc_final_horizonals do |t|
      integer :project_id
      integer :organism_id
      integer :organism_code
      integer :allelea
      integer :alleleb
      integer :extraction_number

      t.timestamps
    end
  end

  def self.down
    drop_table :mhc_final_horizonals
  end
end
