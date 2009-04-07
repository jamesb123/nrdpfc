class AddLocusIdMicrosatellite < ActiveRecord::Migration
  def self.up
    add_column :dna_results, :extraction_method_id, :integer
    add_column :microsatellites, :locu_id, :integer
    add_column :genders, :locu_id, :integer
    add_column :mhcs, :locu_id, :integer
    add_column :mt_dnas, :locu_id, :integer
    add_column :y_chromosomes, :locu_id, :integer
  end

  def self.down
    remove_column :dna_results, :extraction_method_id
    remove_column :microsatellites, :locu_id
    remove_column :genders, :locu_id
    remove_column :mhcs, :locu_id
    remove_column :mt_dnas, :locu_id
    remove_column :y_chromosomes, :locu_id
  end
end
