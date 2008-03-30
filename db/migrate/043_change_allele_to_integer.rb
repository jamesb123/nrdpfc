class ChangeAlleleToInteger < ActiveRecord::Migration
  def self.up
    change_column :microsatellites, :allele1, :integer
    change_column :microsatellites, :allele2, :integer
  end

  def self.down
    change_column :microsatellites, :allele1, :float
    change_column :microsatellites, :allele2, :float
  end
end
