# == Schema Information
#
# Table name: samples
#
#  id                   :integer(11)   not null, primary key
#  project_id           :integer(11)   
#  organism_id          :integer(11)   
#  organism_code        :string(255)   
#  org_sample           :string(255)   
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
#  UTM_datum            :float         
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
  has_many :dna_results
  
  extend Exportables::ExportableModel
  
  RESULT_TABLES = %w[genders microsatellites mhcs mt_dnas y_chromosomes]
  
  for table_name in RESULT_TABLES
    has_many table_name.to_sym
    has_many "final_#{table_name}".to_sym,
      :class_name => table_name.classify,
      :conditions => "#{table_name}.finalResult",
      :order => "#{table_name}.id"
  end
  
  has_many :mhc_seqs
  has_many :microsatellite_horizontals
  belongs_to :locality_type
  belongs_to :shippingmaterial
  belongs_to :tissue_type
  belongs_to :extraction_method
    
  # before_save :assign_loc_type

  before_create :assign_project_id

  # def assign_loc_type
  #   self.loctype = self.locality_type.locality_type_name
  # end


  def assign_project_id
    self.project_id = current_user.current_project.id
  end
  
  def to_label 
    "Code:#{organism_code} Sample:#{org_sample}" 
  end
  
  def security_settings
    current_user.authorization_display_for self.project
  end

  def authorized_for_create?
    true
  end
  
  def authorized_for_update?
    # this method gets called for rows and for Class level questions, so this check returns true at the class level
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE)
  end
  
  def authorized_for_read?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_ONLY)
  end

  def authorized_for_destroy?
    return true unless existing_record_check?
    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE_DELETE)
  end
      
end
