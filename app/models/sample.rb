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
  belongs_to :storage_medium
  
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
  before_save :assign_true_coords, :if => :has_coordinates?
  before_save :assign_locality_type, :if => :has_locality_type?

  validates_presence_of :type_lat_long, :if => :has_coordinates?
  validates_presence_of :UTM_datum, :if => :requires_utm_datum?

  def validate
    if has_coordinates?
      errors.add(:base, "Latitude and Longitude must be written in the chosen format") unless geocoords.format_correct?
      errors.add(:UTM_datum, "must include the UTM Zone") if requires_utm_datum? && geocoords.utm_zone.nil?
      errors.add(:UTM_datum, "must include the UTM Datum used") if requires_utm_datum? && geocoords.utm_datum_version.nil?
    end
  end
  
  def assign_locality_type
    self.locality_type_text =  self.locality_type.to_label
  end
  
  def has_locality_type?
    !self.locality_type_id.blank? 
  end

  def assign_true_coords
    self.true_latitude, self.true_longitude = geocoords.decimal_lat_long
  end

  def self.guess_true_coordinates!
    Sample.all.each do |s|
      s.send(:save_without_validation) if s.has_coordinates?
    end
  end

  # There has been some problems with MySQL truncating the coordinate values
  # You can run this method to check all the samples and make sure the database
  # is storing their values correctly
  def self.check_coordinate_storage!
    self.all.each do |s|
      if s.has_coordinates?
        pair = s.geocoords.decimal_lat_long
        # Compare them to three decimal places. Floating point math can
        # cause it to skew by a few thousandths.
        unless pair.nil? || pair[0].nil? ||
               ((BigDecimal.new(pair[0].to_s) * 1000).to_i == (s.true_latitude * 1000).to_i &&
                (BigDecimal.new(pair[1].to_s) * 1000).to_i == (s.true_longitude * 1000).to_i)

          puts s.inspect
          raise "bad storage"
        end
      end
    end
  end

  def geocoords
    @geocoords ||= GeoCoordinates.new(:longitude => self.longitude,
                                      :latitude => self.latitude,
                                      :utm_datum => self.UTM_datum,
                                      :format => self.type_lat_long)
  end

  def requires_utm_datum?
    has_coordinates? &&
    self.geocoords.data_format == :utm
  end

  def has_coordinates?
    !self.latitude.blank? && !self.longitude.blank?
  end
  

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
