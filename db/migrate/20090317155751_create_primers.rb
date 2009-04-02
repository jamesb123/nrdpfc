class CreatePrimers < ActiveRecord::Migration
  def self.up
    create_table :primers do |t|
      t.column :name, :string
      t.column :label, :string
      t.column :name_label, :string
      t.column :paper_reference, :string
      t.column :sequence, :string
      t.column :comments, :string
      t.column :date_primer_ordered, :datetime
      t.column :company , :string
      t.column :lot_number , :string 
      t.column :date_primer_received, :string 
      t.column :room , :string 
      t.column :freezer , :string 
      t.column :box_number , :string 
      t.column :box_type , :string 
      t.column :lane_inactive , :string 
      t.column :lane_active , :string 
      t.column :entered_by, :string 
      t.column :estimated_40uM_stock , :float 
      t.column :estimated_100uM_stock , :float 
      t.column :estimated_200uM_stock , :float 
    end  
  end

  def self.down
    drop_table :primers
  end
end
