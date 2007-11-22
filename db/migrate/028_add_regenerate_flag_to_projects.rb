class AddRegenerateFlagToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :recompile_required, :boolean
  end

  def self.down
    remove_column :projects, :recompile_required
  end
end
