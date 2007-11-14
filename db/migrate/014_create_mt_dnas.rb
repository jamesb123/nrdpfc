class CreateMtDnas < ActiveRecord::Migration
  def self.up
    create_table :mt_dnas do |t|
      t.column :sample_id, :integer
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :haplotype, :string
      t.column :gelNum, :string
      t.column :wellNum, :string
      t.column :finalResult, :boolean    
    end
  end

  def self.down
    drop_table :mt_dnas
  end
end
