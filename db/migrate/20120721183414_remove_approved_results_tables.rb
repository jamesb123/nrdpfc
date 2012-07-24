class RemoveApprovedResultsTables < ActiveRecord::Migration
  def self.up
    remove_column :genders, :approved
    remove_column :mhcs, :approved
    remove_column :mt_dnas, :approved
    remove_column :microsatellites, :approved
    remove_column :y_chromosomes, :approved
    remove_column :organisms, :approved
    remove_column :dna_results, :approved
  end

  def self.down
    add_column :genders, :approved, :boolean
    add_column :mhcs, :approved, :boolean
    add_column :mt_dnas, :approved, :boolean
    add_column :microsatellites, :approved, :boolean
    add_column :y_chromosomes, :approved, :boolean
    add_column :organisms, :approved, :boolean
    add_column :dna_results, :approved, :boolean
  end
end
