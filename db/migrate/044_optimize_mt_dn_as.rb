class OptimizeMtDnAs < ActiveRecord::Migration
  def self.up
    change_column :mt_dnas, :haplotype, :string, :limit => 1
  end

  def self.down
    change_column :mt_dnas, :haplotype, :string
  end
end
