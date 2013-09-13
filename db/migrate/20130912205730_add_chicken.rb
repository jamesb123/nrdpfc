class AddChicken < ActiveRecord::Migration
  def self.up
    add_column :samples, :chicken_barcode, :string
    add_column :samples, :chicken_sample_date, :string
    add_column :samples, :chicken_contact, :string
    add_column :samples, :chicken_company, :string
    add_column :samples, :chicken_strain, :string
    add_column :samples, :chicken_feathering, :string
    add_column :samples, :chicken_package, :string
    add_column :samples, :chicken_declared_gender, :string
    add_column :samples, :chicken_meat_part, :string
    add_column :samples, :chicken_ml_duplicate, :string
    add_column :samples, :chicken_comments, :string
    add_column :projects, :opt_col_1, :string
    add_column :projects, :opt_col_2, :string
    add_column :projects, :opt_col_3, :string
    add_column :projects, :opt_col_4, :string
    
  end

  def self.down
    remove_column :samples, :chicken_barcode, :string
    remove_column :samples, :chicken_sample_date, :string
    remove_column :samples, :chicken_contact, :string
    remove_column :samples, :chicken_company, :string
    remove_column :samples, :chicken_strain, :string
    remove_column :samples, :chicken_feathering, :string
    remove_column :samples, :chicken_package, :string
    remove_column :samples, :chicken_declared_gender, :string
    remove_column :samples, :chicken_meat_part, :string
    remove_column :samples, :chicken_ml_duplicate, :string
    remove_column :samples, :chicken_comments, :string
    remove_column :projects, :opt_col_1, :string
    remove_column :projects, :opt_col_2, :string
    remove_column :projects, :opt_col_3, :string
    remove_column :projects, :opt_col_4, :string
  end
end
