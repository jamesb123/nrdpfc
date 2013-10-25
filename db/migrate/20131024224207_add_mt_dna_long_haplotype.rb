class AddMtDnaLongHaplotype < ActiveRecord::Migration
  def self.up
    add_column :mt_dnas, :haplotype_long, :string
  end

  def self.down
    remove_column :mt_dnas, :haplotype_long
  end
end
