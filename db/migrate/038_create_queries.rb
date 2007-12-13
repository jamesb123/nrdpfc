class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.integer :project_id
      t.string :name, :limit => 100
      t.boolean :draft, :default => true
      t.text :data
      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
