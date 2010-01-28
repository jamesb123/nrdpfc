class AddSampleIndexes < ActiveRecord::Migration
  def self.up
    add_index "genders", ["sample_id"]
    add_index "mhcs", ["sample_id"]
    add_index "mt_dnas", ["sample_id"]
    add_index "y_chromosomes", ["sample_id"]
    add_index "locus", ["project_id"]
  end

  def self.down
    remove_index "genders", ["sample_id"]
    remove_index "mhcs", ["sample_id"]
    remove_index "mt_dnas", ["sample_id"]
    remove_index "y_chromosomes", ["sample_id"]
    remove_index "locus", ["project_id"]
  end
end
