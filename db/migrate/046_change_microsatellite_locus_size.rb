class ChangeMicrosatelliteLocusSize < ActiveRecord::Migration
   def self.up
    change_column :microsatellites, :locus, :string, :limit => 30
  end

  def self.down
    change_column :microsatellites, :haplotype, :string, :limit => 1
  end

end
