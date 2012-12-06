class AddFkMtDnaSeqs < ActiveRecord::Migration
  def self.up
#    add_column :mt_dna_seqs, :locu_id, :integer
#    add_column :mt_dna_seqs, :mt_dna_id, :integer
  end

  def self.down
    remove_column :mt_dna_seqs, :locu_id
    remove_column :mt_dna_seqs, :mt_dna_id
  end
end
