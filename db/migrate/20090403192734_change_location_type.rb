class ChangeLocationType < ActiveRecord::Migration
  def self.up
    rename_column :samples, :locality_type, :locality_type_text
  end

  def self.down
    rename_column :samples, :locality_type_text, :locality_type
  end
end
