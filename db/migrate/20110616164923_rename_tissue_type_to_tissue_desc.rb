class RenameTissueTypeToTissueDesc < ActiveRecord::Migration
  def self.up
      rename_column :tissue_types, :tissue_type, :tissue_desc
  end

  def self.down
      rename_column :tissue_types, :tissue_desc, :tissue_type 
  end
end
