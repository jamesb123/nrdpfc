class ChangeOrganizationIdToInteger < ActiveRecord::Migration
  def self.up
    rename_column :samples, :organization_id, :organization_text
    add_column :samples, :organization_id, :integer
  end

  def self.down
    rename_column :samples, :organization_text, :organization_id
    remove_column :samples, :organization_id
  end
end
