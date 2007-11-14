class CreateYChromosomeSeqs < ActiveRecord::Migration
  def self.up
    create_table :y_chromosome_seqs do |t|
      t.column :sample_id, :integer    
      t.column :project_id, :integer    
      t.column :locus, :string
      t.column :haplotype, :string
      t.column :sequence, :text
    end
  end

  def self.down
    drop_table :y_chromosome_seqs
  end
end
