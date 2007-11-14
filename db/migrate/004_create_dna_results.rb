class CreateDnaResults < ActiveRecord::Migration
  def self.up
    create_table :dna_results do |t|
      t.column :sample_id, :integer
      t.column :project_id, :integer
      t.column :prep_number, :integer
      t.column :extraction_number, :integer
      t.column :barcode, :string
      t.column :plate, :string
      t.column :position, :string
      t.column :extraction_method, :string
      t.column :extraction_date, :date
      t.column :extractor, :string
      t.column :extractor_comments, :string
      t.column :fluoro_conc, :float
      t.column :functional_conc, :float 
      t.column :pico_green_conc, :float
      t.column :storage_building, :string
      t.column :storage_room, :string
      t.column :storage_freezer, :string
      t.column :storage_box, :string
      t.column :xy_position, :string
      t.column :dna_remaining, :boolean      
    end
  end

  def self.down
    drop_table :dna_results
  end
end

