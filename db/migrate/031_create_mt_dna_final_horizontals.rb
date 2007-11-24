class CreateMtDnaFinalHorizontals < ActiveRecord::Migration
  def self.up
    create_table :mt_dna_final_horizontals do |t|
      t.integer :project_id
      t.integer :organism_id
      t.integer :organism_code
      t.integer :haplotype
      t.integer :extraction_number
      t.timestamps
    end
  end

  def self.down
    drop_table :mt_dna_final_horizontals
  end
end