class CreateSampleLookups < ActiveRecord::Migration
  def self.up
    add_column :samples, :locality_type_id, :integer
    add_column :samples, :shippingmaterial_id, :integer
    add_column :samples, :tissue_type_id, :integer
    add_column :samples, :province_id, :integer
    add_column :samples, :storage_medium_id, :integer
    add_column :samples, :country_id, :integer
  end

  def self.down
    remove_column :samples, :locality_type_id
    remove_column :samples, :shippingmaterial_id
    remove_column :samples, :tissue_type_id
    remove_column :samples, :province_id, :integer
    remove_column :samples, :storage_medium_id, :integer
    remove_column :samples, :country_id, :integer
  end
end
