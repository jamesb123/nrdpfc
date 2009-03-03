class AddPeakAlleleMicrosatellite < ActiveRecord::Migration
  def self.up
    add_column :microsatellites, :allele_1_peak_height, :decimal, :precision => 6, :scale => 2
    add_column :microsatellites, :allele_2_peak_height, :decimal, :precision => 6, :scale => 2
  end

  def self.down
    remove_column :microsatellites, :allele_1_peak_height
    remove_column :microsatellites, :allele_2_peak_height
  end
end
