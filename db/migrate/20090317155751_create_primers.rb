class CreatePrimers < ActiveRecord::Migration
  def self.up
    create_table :primers do |t|
      t.column :primer, :string
      t.column :label, :string
      t.column :locus_id, :integer
      t.column :paper_reference, :string
      t.column :primer_sequence, :string
      t.column :comments, :string
      t.column :date_primer_ordered, :date
      t.column :company , :string
      t.column :lot_number , :string 
      t.column :date_primer_received, :date
      t.column :room , :string 
      t.column :freezer , :string 
      t.column :box_number , :string 
      t.column :box_type , :string 
      t.column :lane_inactive , :string 
      t.column :lane_active , :string 
      t.column :entered_by, :string 
      t.column :stock_conc, :integer 
      t.column :alquot_conc, :integer
    end  
  end

  def self.down
    drop_table :primers
  end
end
