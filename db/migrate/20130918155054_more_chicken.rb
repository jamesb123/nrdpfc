class MoreChicken < ActiveRecord::Migration
  def self.up
    add_column :samples, :chicken_country, :string
    remove_column :samples, :chicken_strain
    remove_column :samples, :chicken_package
  end

  def self.down
    remove_column :samples, :chicken_country
    add_column :samples, :chicken_strain, :string
    add_column :samples, :chicken_package, :string
  end
end
