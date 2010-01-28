class AddDynamicAttributeIndexes < ActiveRecord::Migration
  def self.up
    add_index :dynamic_attributes, :scoper_type
    add_index :dynamic_attributes, :scoper_id
  end

  def self.down
    remove_index :dynamic_attributes, :scoper_type
    remove_index :dynamic_attributes, :scoper_id
  end
end
