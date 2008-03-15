class RemoveOrganismCode < ActiveRecord::Migration
  def self.up
    remove_column :samples, :organism_code
    rename_column :samples, :org_sample, :organism_index
  end

  def self.down
   add_column :samples, :organism_code, :string
  end
end
