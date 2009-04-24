class StorageMaterialLookup < ActiveRecord::Migration
  def self.up
    rename_column 'samples', 'storage_medium', 'storage_medium_text'

    create_table 'storage_media' do |t|
      t.string :storage_medium
    end 
    execute 'INSERT INTO storage_media (storage_medium) SELECT (medium_short_desc) AS sm FROM shippingmaterials '
    

    # execute 'INSERT INTO storage_media (storage_medium) SELECT DISTINCT UPPER(storage_medium_text) AS sm FROM samples WHERE storage_medium_text IS NOT NULL ORDER BY sm'
    # execute 'update samples set storage_medium_id = (select id from storage_media where storage_medium = UPPER(samples.storage_medium_text)) where storage_medium_text is not null'
  end

  def self.down
    drop_table :storage_media

    rename_column 'samples', 'storage_medium_text', 'storage_medium'
  end
end
