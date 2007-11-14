class AddIndexesToMicrosatellites < ActiveRecord::Migration
  def self.up
    add_index :microsatellites, :locus
    add_index :microsatellites, :allele1
    add_index :microsatellites, :allele2
    add_index :microsatellites, :finalResult
    
  end

  def self.down
    remove_index :microsatellites, :locus
    remove_index :microsatellites, :allele1
    remove_index :microsatellites, :allele2
    remove_index :microsatellites, :finalResult
  end
end
