class CreateMhcs < ActiveRecord::Migration
  def self.up
    create_table :mhcs do |t|
      t.column :sample_id, :integer    
      t.column :project_id, :integer    
      t.column :locus, :string
      t.column :allele1, :string
      t.column :allele2, :string
      t.column :gelNum, :string
      t.column :wellNum, :string
      t.column :finalResult, :boolean
    end
  end

  def self.down
    drop_table :mhcs
  end
end
