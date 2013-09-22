class MoreOptionalColumns < ActiveRecord::Migration
  def self.up
    remove_column :samples, :chicken_barcode
    remove_column :samples, :chicken_sample_date
    remove_column :samples, :chicken_contact
    remove_column :samples, :chicken_comments
    add_column :projects, :opt_col_5, :string
    add_column :projects, :opt_col_6, :string
    add_column :projects, :opt_col_7, :string
    add_column :projects, :opt_col_8, :string
    add_column :projects, :opt_col_9, :string
    add_column :projects, :opt_col_10, :string
    add_column :projects, :opt_col_11, :string
    add_column :projects, :opt_col_12, :string
    add_column :projects, :opt_col_13, :string
    add_column :projects, :opt_col_14, :string
    add_column :projects, :opt_col_15, :string
    add_column :projects, :opt_col_16, :string
    add_column :projects, :opt_col_17, :string
    add_column :projects, :opt_col_18, :string
    add_column :projects, :opt_col_19, :string
    add_column :projects, :opt_col_20, :string
    add_column :projects, :opt_col_21, :string
    add_column :projects, :opt_col_22, :string
    add_column :projects, :opt_col_23, :string
    add_column :projects, :opt_col_24, :string
    add_column :projects, :opt_col_25, :string
  end

  def self.down
    add_column :samples, :chicken_barcode, :string
    add_column :samples, :chicken_sample_date, :string
    add_column :samples, :chicken_contact, :string
    add_column :samples, :chicken_comments, :string
    remove_column :projects, :opt_col_5 
    remove_column :projects, :opt_col_6 
    remove_column :projects, :opt_col_7 
    remove_column :projects, :opt_col_8 
    remove_column :projects, :opt_col_9 
    remove_column :projects, :opt_col_10 
    remove_column :projects, :opt_col_11 
    remove_column :projects, :opt_col_12 
    remove_column :projects, :opt_col_13 
    remove_column :projects, :opt_col_14 
    remove_column :projects, :opt_col_15 
    remove_column :projects, :opt_col_16 
    remove_column :projects, :opt_col_17 
    remove_column :projects, :opt_col_18 
    remove_column :projects, :opt_col_19 
    remove_column :projects, :opt_col_20 
    remove_column :projects, :opt_col_21 
    remove_column :projects, :opt_col_22 
    remove_column :projects, :opt_col_23 
    remove_column :projects, :opt_col_24 
    remove_column :projects, :opt_col_25 
  end
end
