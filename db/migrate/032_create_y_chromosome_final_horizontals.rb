class CreateYChromosomeFinalHorizontals < ActiveRecord::Migration
  def self.up
    create_table :y_chromosome_final_horizontals do |t|
      integer :project_id
      integer :organism_id
      integer :organism_code
      integer :haplotype
      integer :extraction_number
      t.timestamps
    end
  end

  def self.down
    drop_table :y_chromosome_final_horizontals
  end
end
