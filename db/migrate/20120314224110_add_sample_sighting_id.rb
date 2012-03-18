class AddSampleSightingId < ActiveRecord::Migration
  def self.up
    add_column :samples, :photo_id, :integer
    add_column :samples, :remote_data_entry, :boolean
    add_column :samples, :discrepancy, :string
    add_column :samples, :discrepancy_comments, :text
  end

  def self.down
    remove_column :samples, :photo_id
    remove_column :samples, :remote_data_entry
    remove_column :samples, :discrepancy
    remove_column :samples, :discrepancy_comments
  end
end
