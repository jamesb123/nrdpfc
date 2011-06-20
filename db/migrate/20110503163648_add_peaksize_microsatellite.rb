class AddPeaksizeMicrosatellite < ActiveRecord::Migration
  def self.up
    add_column :microsatellites, :allele_1_size, :decimal, :precision => 6, :scale => 2
    add_column :microsatellites, :allele_2_size, :decimal, :precision => 6, :scale => 2
    add_column :mt_dna_seqs, :comments, :text
  end

  def self.down
    remove_column :microsatellites, :allele_1_size
    remove_column :microsatellites, :allele_2_size
    remove_column :mt_dna_seqs, :comments
  end
end
