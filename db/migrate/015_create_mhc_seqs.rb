class CreateMhcSeqs < ActiveRecord::Migration
  def self.up
    create_table :mhc_seqs do |t|
      t.column :project_id, :integer    
      t.column :locus, :string
      t.column :allele, :string
      t.column :sequence, :text
    end
  end

  def self.down
    drop_table :mhc_seqs
  end
end
