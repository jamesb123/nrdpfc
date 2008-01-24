class ChangeQueryFields < ActiveRecord::Migration
  def self.up
    remove_column :queries, :data
  end

  def self.down
    add_column :queries, :data, :text
  end
end
