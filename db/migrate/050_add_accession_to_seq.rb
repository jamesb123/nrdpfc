class AddAccessionToSeq < ActiveRecord::Migration
  def self.up
      rename_column :y_chromosome_seqs, :haplotype, :allele
      add_column :mhc_seqs, :accession, :string, :limit => 30
      add_column :y_chromosome_seqs, :accession, :string, :limit => 30
  end

  def self.down
      rename_column :y_chromosome_seqs, :allele, :haplotype
      remove_column :mhc_seqs, :accession
      remove_column :y_chromosome_seqs, :accession
  end
end
