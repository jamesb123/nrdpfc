class AddDynamicAttributeIndexes < ActiveRecord::Migration
  def self.up
    add_index :dynamic_attributes, :scoper_type
    add_index :dynamic_attributes, :scoper_id
    add_index :dynamic_attributes, :owner_type
  end

  def self.down
    remove_index :dynamic_attributes, :scoper_type
    remove_index :dynamic_attributes, :scoper_id
    remove_index :dynamic_attributes, :owner_type
  end
end
