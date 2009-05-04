class ChangeOrganismIndexToInteger < ActiveRecord::Migration
  def self.up
    change_column :samples, :organism_index, :integer
  end

  def self.down
    change_column :samples, :organism_index, :string
  end
end
