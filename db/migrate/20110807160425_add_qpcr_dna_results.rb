class AddQpcrDnaResults < ActiveRecord::Migration
  def self.up
    add_column :dna_results, :pcr_quantity, :decimal, :precision => 12, :scale=> 4
    add_column :dna_results, :pcr_ct, :string
    add_column :dna_results, :pcr_slope, :decimal, :precision => 10, :scale=> 4
    add_column :dna_results, :pcr_y_intercept, :decimal, :precision => 10, :scale=> 4
    add_column :dna_results, :pcr_rsquared, :decimal, :precision => 5, :scale=> 4
  end

  def self.down
    remove_column :dna_results, :pcr_quantity
    remove_column :dna_results, :pcr_ct
    remove_column :dna_results, :pcr_slope
    remove_column :dna_results, :pcr_y_intercept
    remove_column :dna_results, :pcr_rsquared
  end
end
