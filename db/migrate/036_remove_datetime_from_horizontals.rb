class RemoveDatetimeFromHorizontals < ActiveRecord::Migration
  TABLES = %w[mhc_final_horizontals mt_dna_final_horizontals y_chromosome_final_horizontals gender_final_horizontals]
  def self.up
    for table_name in TABLES
      remove_column table_name, :created_at
      remove_column table_name, :updated_at
    end
  end

  def self.down
    for table_name in TABLES
      add_column table_name, :created_at, :datetime
      add_column table_name, :updated_at, :datetime
    end
  end
end
