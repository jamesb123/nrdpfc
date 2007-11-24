class ChangeOrganismCodeToStringInHorizontalsTables < ActiveRecord::Migration
  TABLES = %w[gender_final_horizontals mhc_final_horizontals microsatellite_final_horizontals microsatellite_horizontals mt_dna_final_horizontals y_chromosome_final_horizontals]
  def self.up
    for table_name in TABLES
      change_column table_name, :organism_code, :string
    end
  end

  def self.down
    for table_name in TABLES
      change_column table_name, :organism_code, :integer
    end
  end
end
