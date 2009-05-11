class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index 'y_chromosomes', 'finalResult'
    add_index 'mt_dnas', 'finalResult'
    add_index 'mhcs', 'finalResult'
    add_index 'genders', 'finalResult'
    add_index 'organisms', 'project_id'
  end

  def self.down
    remove_index 'y_chromosomes', 'finalResult'
    remove_index 'mt_dnas', 'finalResult'
    remove_index 'mhcs', 'finalResult'
    remove_index 'genders', 'finalResult'
    remove_index 'organisms', 'project_id'
  end
end
