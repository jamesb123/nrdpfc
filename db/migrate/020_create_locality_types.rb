class CreateLocalityTypes < ActiveRecord::Migration
  def self.up
    create_table :locality_types do |t|
    t.column :locality_type_name, :string
    t.column :locality_type_desc, :string
    end
  end

  def self.down
    drop_table :locality_types
  end
end
