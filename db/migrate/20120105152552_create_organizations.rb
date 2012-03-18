class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.column :org_name, :string
      t.column :address_id, :integer
    end
  end
  def self.down
    drop_table :organizations
  end
end
