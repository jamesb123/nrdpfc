class AddApprovedIndexes < ActiveRecord::Migration
  def self.up
    add_index :samples, :approved 
    add_index :organisms, :approved
    add_index :dna_results, :approved
    add_index :genders, :approved
    add_index :microsatellites, :approved
    add_index :mhcs, :approved
    add_index :mt_dnas, :approved
    add_index :y_chromosomes, :approved
  end

  def self.down
    remove_index :samples, :approved 
    remove_index :organisms, :approved
    remove_index :dna_results, :approved
    remove_index :genders, :approved
    remove_index :microsatellites, :approved
    remove_index :mhcs, :approved
    remove_index :mt_dnas, :approved
    remove_index :y_chromosomes, :approved
  end
end
