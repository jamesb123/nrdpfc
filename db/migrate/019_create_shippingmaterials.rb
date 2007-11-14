class CreateShippingmaterials < ActiveRecord::Migration
  def self.up
    create_table :shippingmaterials do |t|
      t.column :sample_id, :integer
      t.column :medium_short_desc, :string
      t.column :medium_long_desc, :string
    end
  end

  def self.down
    drop_table :shippingmaterials
  end
end
