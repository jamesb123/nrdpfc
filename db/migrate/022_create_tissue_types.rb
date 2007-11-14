class CreateTissueTypes < ActiveRecord::Migration
  def self.up
    create_table :tissue_types do |t|
      t.column :tissue_type, :string
      t.column :comment, :string
    end    
  end

  def self.down
    drop_table :tissue_types
  end
end
