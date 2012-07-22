class RemoveApprovedResultsTables < ActiveRecord::Migration
  def self.up
    remove_column :genders, :approved
    remove_column :mhcs, :approved
    remove_column :mt_dnas, :approved
    remove_column :microsatellites, :approved
    remove_column :y_chromosomes, :approved
    
  end

  def self.down
    add_column :genders, :approved, :string
#    add_column :mhcs, :approved
#    add_column :mt_dnas, :approved
#    add_column :microsatellites, :approved
#    add_column :y_chromosomes, :approved
  end
end
