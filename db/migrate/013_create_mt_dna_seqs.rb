class CreateMtDnaSeqs < ActiveRecord::Migration
  def self.up
    create_table :mt_dna_seqs do |t|
      t.column :project_id, :integer    
      t.column :locus, :string
      t.column :haplotype, :string
      t.column :sequence, :text
    end
  end

  def self.down
    drop_table :mt_dna_seqs
  end
end
