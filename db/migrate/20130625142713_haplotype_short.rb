class HaplotypeShort < ActiveRecord::Migration
  def self.up
    add_column :mt_dnas, :haplotype_short, :string
  end

  def self.down
    remove_column :mt_dnas, :haplotype_short, :string
  end
end
