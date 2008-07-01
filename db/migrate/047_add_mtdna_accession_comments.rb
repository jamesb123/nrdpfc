class AddMtdnaAccessionComments < ActiveRecord::Migration
  def self.up
      add_column :mt_dnas_seqs, :accession, :string, :limit => 30
  end

  def self.down
      remove_column :mt_dnas, :accession
  end
end
