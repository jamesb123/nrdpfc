class AddDataEntryUser < ActiveRecord::Migration
  def self.up
    add_column :users, :data_entry_only, :boolean, :default => false
  end

  def self.down
    remove_column :users, :data_entry_only
  end
end
