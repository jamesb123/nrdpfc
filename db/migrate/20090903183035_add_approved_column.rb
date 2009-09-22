class AddApprovedColumn < ActiveRecord::Migration
  def self.up
    add_column :samples, :approved, :boolean, :default => false 
    add_column :organisms, :approved, :boolean, :default => false
    add_column :dna_results, :approved, :boolean, :default => false
    add_column :genders, :approved, :boolean, :default => false
    add_column :microsatellites, :approved, :boolean, :default => false
    add_column :mhcs, :approved, :boolean, :default => false
    add_column :mt_dnas, :approved, :boolean, :default => false
    add_column :y_chromosomes, :approved, :boolean, :default => false
    
  end

  def self.down
    remove_column :samples, :approved
    remove_column :organsims, :approved
    remove_column :dna_results, :approved
    remove_column :genders, :approved
    remove_column :microsatellites, :approved
    remove_column :mhcs, :approved, :boolean
    remove_column :mt_dnas, :approved
    remove_column :y_chromosomes, :approved
  end
end
