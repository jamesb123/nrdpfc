class RemoveExtractionNumberFromHorizontals < ActiveRecord::Migration
  def self.up
    remove_column :mhc_final_horizontals, :extraction_number
    remove_column :y_chromosome_final_horizontals, :extraction_number
    remove_column :mt_dna_final_horizontals, :extraction_number
  end

  def self.down
    add_column :mhc_final_horizontals, :extraction_number, :string
    add_column :mt_dna_final_horizontals, :extraction_number, :string
    add_column :y_chromosome_final_horizontals, :extraction_number, :string
  end
end
