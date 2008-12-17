class AddPersistentQueries < ActiveRecord::Migration
  def self.up
    create_table 'data_queries' do |t|
      t.text 'data'
      t.integer 'project_id'
      t.string 'access_key'

      t.datetime 'accessed_at'
      t.timestamps
    end
  end

  def self.down
    drop_table :data_query
  end
end
