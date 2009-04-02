class CreateLocus < ActiveRecord::Migration
  def self.up
    create_table :locus do |t|
      t.column :locus, :string
      t.column :region, :string
      t.column :marker, :string
      t.column :conditions_data, :string
      t.column :pdf_name, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :locus
  end
end
