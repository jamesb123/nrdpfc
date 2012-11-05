class AddWolfColumnsDiet < ActiveRecord::Migration
  def self.up
    change_column :samples, :organism_index, :string
    change_column :samples, :photo_id, :string
    add_column :samples, :age, :string
    add_column :samples, :condition, :string
    add_column :samples, :rehydrated, :string
    add_column :samples, :diet_analysis, :string
  end

  def self.down
    change_column :samples, :organism_index, :integer
    change_column :samples, :photo_id, :integer
    remove_column :samples, :age
    remove_column :samples, :condition
    remove_column :samples, :rehydrated
    remove_column :samples, :diet_analysis
  end
end
