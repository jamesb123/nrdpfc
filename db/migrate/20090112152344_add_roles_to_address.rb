class AddRolesToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :role_id, :integer
  end

  def self.down
    remove_column :addresses, :role_id
  end
end
