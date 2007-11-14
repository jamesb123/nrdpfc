class CreateExtractionMethods < ActiveRecord::Migration
  
  def self.up
    add_column :samples, :extraction_method_id, :integer
    create_table :extraction_methods do |t|
      t.column :extraction_method_name, :string
      t.column :extraction_method_description, :string
    end
  end

  def self.down
    remove_column :samples, :extraction_method_id
    drop_table :extraction_methods
  end
end
