class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :short_role, :string
      t.column :long_role, :string
    end
  end

  def self.down
    drop_table :roles
  end
end
