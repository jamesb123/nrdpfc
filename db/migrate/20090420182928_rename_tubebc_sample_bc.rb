class RenameTubebcSampleBc < ActiveRecord::Migration
  def self.up
    rename_column :samples, :tubebc, :sample_bc
  end

  def self.down
    rename_column :samples, :sample_bc, :sample_bc
  end
end
