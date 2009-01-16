class AddBcToSample < ActiveRecord::Migration
  def self.up
    add_column :samples, :sample_bc_prv, :string
    add_column :samples, :shipping_material_txt_prv, :string
  end

  def self.down
    remove_column :samples, :sample_bc_prv
    remove_column :samples, :shipping_material_txt_prv
  end
end
