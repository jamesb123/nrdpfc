class AddProjectLabels < ActiveRecord::Migration
  def self.up
    add_column :projects, :organism_label, :string
    add_column :projects, :photo_id_label, :string
    add_column :projects, :field_ident_label, :string
    
    change_column :microsatellites, :allele_1_peak_height, :decimal, :precision => 6, :scale => 0
    change_column :microsatellites, :allele_2_peak_height, :decimal, :precision => 6, :scale => 0

  end

  def self.down
    remove_column :projects, :photo_id_label
    change_column :microsatellites, :allele_1_peak_height, :decimal, :precision => 6, :scale => 2
    change_column :microsatellites, :allele_2_peak_height, :decimal, :precision => 6, :scale => 2
  end
end
