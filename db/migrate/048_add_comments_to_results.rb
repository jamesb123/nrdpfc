class AddCommentsToResults < ActiveRecord::Migration
  def self.up
    add_column :dna_results, :comments, :text
    add_column :mt_dnas, :comments, :text
    add_column :genders, :comments, :text
    add_column :microsatellites, :comments, :text
    add_column :mhcs, :comments, :text
    add_column :y_chromosomes, :comments, :text
  end

  def self.down
    add_column :dna_results, :comments, :text
    add_column :mt_dnas, :comments, :text
    add_column :genders, :comments, :text
    add_column :microsatellites, :comments, :text
    add_column :mhcs, :comments, :text
    add_column :y_chromosomes, :comments, :text
  end
end
