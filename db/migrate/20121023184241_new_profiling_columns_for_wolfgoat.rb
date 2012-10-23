class NewProfilingColumnsForWolfgoat < ActiveRecord::Migration
  def self.up
    add_column :samples, :profiling_done_by, :string
    add_column :samples, :profiling_funded_by, :string
    add_column :samples, :profile_published, :string
    add_column :samples, :publication_name, :string
  end

  def self.down
    remove_column :samples, :profiling_done_by 
    remove_column :samples, :profiling_funded_by 
    remove_column :samples, :profile_published
    remove_column :samples, :publication_name
  end
end
