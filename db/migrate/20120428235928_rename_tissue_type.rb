class RenameTissueType < ActiveRecord::Migration
  def self.up
    rename_column :samples, :tissue_type, :text_tissue_type
  end

  def self.down
    rename_column :samples, :text_tissue_type, :tissue_type
  end
end
