class CreateGenderLocus < ActiveRecord::Migration
  def self.up
    create_table :gender_locus do |t|
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :region, :string
      t.column :marker, :string
      t.column :conditions_data, :string
      t.column :pdf_name, :string
      t.timestamps
    end
create_table :mhc_locus do |t|
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :region, :string
      t.column :marker, :string
      t.column :conditions_data, :string
      t.column :pdf_name, :string
      t.timestamps
    end
create_table :mt_dna_locus do |t|
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :region, :string
      t.column :marker, :string
      t.column :conditions_data, :string
      t.column :pdf_name, :string
      t.timestamps
    end
create_table :y_chromosme_locus do |t|
      t.column :project_id, :integer
      t.column :locus, :string
      t.column :region, :string
      t.column :marker, :string
      t.column :conditions_data, :string
      t.column :pdf_name, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :gender_locus
    drop_table :mhc_locus
    drop_table :mt_dna_locus
    drop_table :y_chromosome_locus
  end
end
