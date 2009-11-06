# == Schema Information
#
# Table name: sample_non_tissues
#
#  id                 :integer(11)   not null, primary key
#  organism_id        :integer(11)   
#  project_id         :integer(11)   
#  field_code         :string(255)   
#  prov               :string(255)   
#  country            :string(255)   
#  date_collected     :date          
#  collected_by       :string(255)   
#  submitted_by       :string(255)   
#  date_submitted     :date          
#  submitter_comments :text          
#  received_by        :string(255)   
#  date_received      :date          
#  receiver_comments  :text          
#  latitude           :float         
#  longitude          :float         
#  UTM_datum          :float         
#  locality           :string(255)   
#  locality_type      :string(255)   
#  locality_comments  :string(255)   
#  location_accuracy  :string(255)   
#  type_lat_long      :string(255)   
#

class SampleNonTissue < ActiveRecord::Base

  has_many_dynamic_attributes :scoped_by => 'Project'

  belongs_to :organism

  extend Exportables::ExportableModel
  include ProjectRelations
  include SecuritySets::ProjectBased
  
  def to_label 
    "#{id}" 
  end
  
end
