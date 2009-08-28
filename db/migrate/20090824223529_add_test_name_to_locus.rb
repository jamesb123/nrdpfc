class AddTestNameToLocus < ActiveRecord::Migration
  def self.up
    add_column :locus, :test_name, :string
  end

  def self.down
    remove_column :locu, :test_name
  end
end
