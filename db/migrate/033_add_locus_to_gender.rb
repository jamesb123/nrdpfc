class AddLocusToGender < ActiveRecord::Migration
  def self.up
    add_column :genders, :locus, :string
  end

  def self.down
    remove_column :genders, :locus
  end
end
