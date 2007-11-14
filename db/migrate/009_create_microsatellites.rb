class CreateMicrosatellites < ActiveRecord::Migration

   def self.up
    create_table :microsatellites do |t|
      t.column :sample_id, :integer
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :allele1, :string
      t.column :allele2, :string
      t.column :gel, :string
      t.column :well, :string
      t.column :finalResult, :boolean            
    end
  end

  def self.down
    drop_table :microsatellites
  end
end
