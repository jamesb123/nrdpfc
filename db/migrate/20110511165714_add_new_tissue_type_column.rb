class AddNewTissueTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :samples, :tissue_type, :original_tissue_type
    add_column :samples, :tissue_type, :string
  end

  def self.down
    rename_column :samples, :original_tissue_type, :tissue_type
    remove_column :samples, :tissue_type
  end
end
