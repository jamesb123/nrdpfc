class CreateSampleNonTissues < ActiveRecord::Migration
  def self.up
    create_table :sample_non_tissues do |t|
      t.column :organism_id, :integer
      t.column :project_id, :integer
      t.column :field_code, :string
      t.column :prov, :string
      t.column :country, :string

      t.column :date_collected, :date
      t.column :collected_by, :string

      t.column :submitted_by, :string
      t.column :date_submitted, :date
      t.column :submitter_comments, :text

      t.column :received_by, :string
      t.column :date_received, :date
      t.column :receiver_comments, :text

      t.column :latitude, :float
      t.column :longitude, :float
      t.column :UTM_datum, :float
      t.column :locality, :string
      t.column :locality_type, :string
      t.column :locality_comments, :string
      t.column :location_accuracy, :string
      t.column :type_lat_long, :string     
    end
  end

  def self.down
    drop_table :sample_non_tissues
  end
end
