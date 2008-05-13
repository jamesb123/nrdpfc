class ChangeMtdnaHaplotypeSize < ActiveRecord::Migration
  def self.up
    change_column :mt_dnas, :haplotype, :string, :limit => 12
  end

  def self.down
    change_column :mt_dnas, :haplotype, :string, :limit => 1
  end
end
