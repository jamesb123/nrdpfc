class MakeMicrosatelliteAllelesIntoFloatsAndRestrictLocusSize < ActiveRecord::Migration
  def self.up
    change_column :microsatellites, :allele1, :float
    change_column :microsatellites, :allele2, :float
    change_column :microsatellites, :locus, :string, :limit => 7
  end

  def self.down
    change_column :microsatellites, :allele1, :string
    change_column :microsatellites, :allele2, :string
    change_column :microsatellites, :locus, :float
  end
end
