class AddProjectIdIndexes < ActiveRecord::Migration
  def self.up
    add_index 'dna_results', 'project_id'
    add_index 'sample_non_tissues', 'project_id'
    add_index 'mt_dna_seqs', 'project_id'
    add_index 'mt_dnas', 'project_id'
    add_index 'mhcs', 'project_id'
    add_index 'genders', 'project_id'
    add_index 'y_chromosomes', 'project_id'
  end

  def self.down
    remove_index 'dna_results', 'project_id'
    remove_index 'sample_non_tissues', 'project_id'
    remove_index 'mt_dna_seqs', 'project_id'
    remove_index 'mt_dnas', 'project_id'
    remove_index 'mhcs', 'project_id'
    remove_index 'genders', 'project_id'
    remove_index 'y_chromosomes', 'project_id'
  end
end
