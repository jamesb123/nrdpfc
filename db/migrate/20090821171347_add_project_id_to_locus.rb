class AddProjectIdToLocus < ActiveRecord::Migration
  def self.up
    add_column :locus, :project_id, :integer
  end

  def self.down
    remove_column :locus, :project_id
  end
end
