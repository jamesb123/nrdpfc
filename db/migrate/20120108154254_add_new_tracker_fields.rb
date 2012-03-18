class AddNewTrackerFields < ActiveRecord::Migration
  def self.up
    add_column :samples, :shipping_date, :date
    add_column :samples, :organization_id, :string
    add_column :samples, :field_ident, :string
    add_column :samples, :current_location, :string
    add_column :samples, :comments, :string
    add_column :samples, :import_permit, :string
    add_column :samples, :export_permit, :string

    add_column :mt_dnas, :date_sequenced, :date
    add_column :genders, :date_genotyped, :date
    add_column :users, :name, :string

    add_column :samples, :received_by_trent, :boolean
    add_column :samples, :dna_extracted, :boolean
    add_column :samples, :profiling_completed, :boolean
    add_column :samples, :user_id, :integer
    add_column :samples, :extraction_date, :date
    add_column :samples, :profiling_date, :date

    add_column :microsatellites, :date_genotyped, :date
  end
  

  def self.down
    remove_column :samples, :organization_id
    remove_column :samples, :field_ident
    remove_column :samples, :current_location
    remove_column :samples, :comments
    remove_column :samples, :import_permit
    remove_column :samples, :export_permit

    remove_column :mt_dnas, :date_sequenced
    remove_column :genders, :date_genotyped
    remove_column :users, :name
    
    remove_column :samples, :received_by_trent
    remove_column :samples, :dna_extracted
    remove_column :samples, :profiling_completed
    remove_column :samples, :user_id
    remove_column :samples, :extraction_date
    remove_column :samples, :profiling_date    

    remove_column :microsatellites, :date_genotyped
    remove_column :samples, :shipping_date

  end
end
