class AddFkToSequenceTables < ActiveRecord::Migration
  def self.up
    add_column :mhc_seqs, :locu_id, :integer
    add_column :mhc_seqs, :y_chromoeome_id, :integer
    add_column :y_chromosome_seqs, :locu_id, :integer
    add_column :y_chromosome_seqs, :y_chromosome_id, :integer
  end

  def self.down
    remove_column :mhc_seqs, :locu_id
    remove_column :mhc_seqs, :mt_dna_id
    remove_column :y_chromosome_seqs, :locu_id
    remove_column :y_chromosome_seqs, :mt_dna_id
  end
end
