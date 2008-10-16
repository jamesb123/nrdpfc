# == Schema Information
#
# Table name: samples
#
#  id                   :integer(11)   not null, primary key
#  project_id           :integer(11)   
#  organism_id          :integer(11)   
#  organism_index       :string(255)   
#  tubebc               :string(255)   
#  platebc              :string(255)   
#  plateposition        :string(255)   
#  field_code           :string(255)   
#  batch_number         :string(255)   
#  tissue_type          :string(255)   
#  storage_medium       :string(255)   
#  country              :string(255)   
#  province             :string(255)   
#  date_collected       :datetime      
#  collected_on_day     :integer(11)   
#  collected_on_month   :integer(11)   
#  collected_on_year    :integer(11)   
#  collected_by         :string(255)   
#  date_received        :datetime      
#  received_by          :string(255)   
#  receiver_comments    :text          
#  date_submitted       :datetime      
#  submitted_by         :string(255)   
#  submitter_comments   :text          
#  latitude             :float         
#  longitude            :float         
#  UTM_datum            :string(255)   
#  locality             :string(255)   
#  locality_type        :string(255)   
#  locality_comments    :string(255)   
#  location_accuracy    :string(255)   
#  storage_building     :string(255)   
#  storage_room         :string(255)   
#  storage_fridge       :string(255)   
#  storage_box          :string(255)   
#  xy_position          :string(255)   
#  tissue_remaining     :boolean(1)    
#  type_lat_long        :string(255)   
#  locality_type_id     :integer(11)   
#  shippingmaterial_id  :integer(11)   
#  tissue_type_id       :integer(11)   
#  province_id          :integer(11)   
#  storage_medium_id    :integer(11)   
#  country_id           :integer(11)   
#  extraction_method_id :integer(11)   
#

class Sample < ActiveRecord::Base
  belongs_to :project
  belongs_to :organism
  belongs_to :locality_type
  belongs_to :shippingmaterial
  belongs_to :tissue_type
  belongs_to :extraction_method

  has_many :y_chromosome_seqs
  has_many :y_chromosomes
  has_many :microsatellite_horizontals
  has_many :microsatellites
  has_many :mt_dnas
  has_many :mt_dna_seqs
  has_many :mhcs
  has_many :mhc_seqs
  has_many :genders
  has_many :dna_results
  
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include SecuritySets::ProjectBased
  
  RESULT_TABLES = %w[genders microsatellites mhcs mt_dnas y_chromosomes]
  
  for table_name in RESULT_TABLES
    has_many table_name.to_sym
    has_many "final_#{table_name}".to_sym,
      :class_name => table_name.classify,
      :conditions => "#{table_name}.finalResult",
      :order => "#{table_name}.id"
  end
  
  
  before_create :assign_project_id
  before_save :assign_date_collected
  


  def assign_date_collected
#    self.date_collected = 
#    self.date_collected = Date.civil(y=:collected_on_year, m=:collected_on_month, d=:collected_on_day,sg=ITALY)
# self.date_collected = now.date
#    self.date_collected.strptime(self.collected_on_year + self.collected_on_month + self.collected_on_day, '%Y %m %d')
  end
  
  def assign_project_id
    self.project_id = current_project_id
  end
  
  def to_label 
    if !organism.nil?  
      return "#{organism.organism_code} - #{organism_index}"
    else
      return "#{self.id} SID" 
    end
  end    
  
end
