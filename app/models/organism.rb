# == Schema Information
#
# Table name: organisms
#
#  id            :integer(11)   not null, primary key
#  project_id    :integer(11)   
#  organism_code :string(255)   
#  comment       :string(255)   
#

class Organism < ActiveRecord::Base
  has_many_dynamic_attributes :scoped_by => 'Project'
  
  has_many :microsatellite_final_horizontals
  has_many :samples
  has_many :gender_final_horizontals
  has_many :mhc_final_horizontals
  has_many :mt_dna_final_horizontals
  has_many :y_chromosome_final_horizontals
  has_many :sample_non_tissues
  has_many :dna_results, :through => :samples
 
  include ProjectRelations
  extend Exportables::DynamicAttributesExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  include ApprovalModelHelpers
  
  for table_name in RESULT_TABLES
    has_many table_name, :through => :samples 
    has_many "final_#{table_name}", :through => :samples
  end

  def to_label
#   "#{organism_code} #{self.id}" 
   "#{self.organism_code}" 
  end
  
end
