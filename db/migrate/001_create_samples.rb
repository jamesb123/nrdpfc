class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.column :project_id, :integer
      t.column :organism_id, :integer
      t.column :organism_code, :string
      t.column :org_sample, :string
      t.column :tubebc, :string
      t.column :platebc, :string  
      t.column :plateposition, :string  
      t.column :field_code, :string        
      t.column :batch_number, :string
      t.column :tissue_type, :string  
      t.column :storage_medium, :string
      t.column :country, :string
      t.column :province, :string
      t.column :date_collected, :datetime
      t.column :collected_on_day, :integer
      t.column :collected_on_month, :integer
      t.column :collected_on_year, :integer
      t.column :collected_by, :string
      t.column :date_received, :datetime
      t.column :received_by, :string
      t.column :receiver_comments, :text
      t.column :date_submitted, :datetime
      t.column :submitted_by, :string
      t.column :submitter_comments, :text
      t.column :latitude, :float
      t.column :longitude, :float
      t.column :UTM_datum, :float
      t.column :locality, :string
      t.column :locality_type, :string
      t.column :locality_comments, :string
      t.column :location_accuracy, :string
      t.column :type_lat_long, :text
      t.column :storage_building, :string
      t.column :storage_room, :string
      t.column :storage_fridge, :string
      t.column :storage_box, :string
      t.column :xy_position, :string
      t.column :tissue_remaining, :boolean
      
     end
  end

  def self.down
    drop_table :samples
  end
end
