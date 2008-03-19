class AddMoreHappyIndexes < ActiveRecord::Migration
  def self.up
    add_index :samples, :organism_id
    add_index :samples, :organism_code
    add_index :samples, :project_id
  end

  def self.down
#    remove_index :samples, :project_id
#    remove_index :samples, :organism_code
#    remove_index :samples, :organism_id
  end
end
