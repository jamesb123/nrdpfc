# see schema at end of model

class Sample < ActiveRecord::Base
  belongs_to :project
  belongs_to :organism
  belongs_to :organization
  belongs_to :user
  
  has_many :y_chromosome_seqs
  has_many :y_chromosomes, :dependent => :destroy
  has_many :microsatellite_horizontals
  has_many :microsatellites, :dependent => :destroy
  has_many :mt_dnas, :dependent => :destroy
  has_many :mhcs, :dependent => :destroy
  has_many :genders, :dependent => :destroy
  has_many :dna_results, :dependent => :destroy
  has_many :snps, :dependent => :destroy
  
  extend Exportables::ExportableModel
  extend GoToOrganismCode::Model
  include ProjectRelations
  include SecuritySets::ProjectBased
  include ApprovalModelHelpers
  
# tmp_string = :collected_on_year
#  validates_numericality_of :collected_on_year, :on => :save
#  validate_format_of :tmp_year, :with =>  :tmp_year.scan(/\D/).empty? and (1582..2500).include?(:tmp_year.to_i)
   validates_format_of :collected_on_year, :with => /^[0-9_\/\s]+$/i , :allow_blank => true

  for table_name in RESULT_TABLES
    has_many table_name.to_sym
    has_many "final_#{table_name}".to_sym,
      :class_name => table_name.classify,
      :conditions => "#{table_name}.finalResult",
      :order => "#{table_name}.id"
  end
  
  
  before_save :assign_true_coords, :if => :has_coordinates?
  before_save :date_collected_fill
  
  validates_presence_of :type_lat_long, :if => :has_coordinates?
  validates_presence_of :coordinate_system, :if => :requires_coordinate_system?

  file_column :sample_image1

  def validate
    if has_coordinates?
      errors.add(:base, "Latitude and Longitude must be written in the chosen format") unless geocoords.format_correct?
      errors.add(:coordinate_system, "must include the UTM Zone") if requires_coordinate_system? && geocoords.utm_zone.nil?
      errors.add(:coordinate_system, "must include the UTM Datum used") if requires_coordinate_system? && geocoords.coordinate_system_version.nil?
    end
  end
  
#  def assign_collected_YMD
#    if self.user_id.nil?
#      self.user_id = self.current_user
#    end
#    if !self.date_collected.nil? and self.collected_on_day.nil? and self.collected_on_month.nil? and self.collected_on_year.nil?
#      self.collected_on_day = self.date_collected.day.to_s
#      self.collected_on_month = self.date_collected.month.to_s
#      self.collected_on_year = self.date_collected.year.to_s
#    end
#  end

  def date_collected_fill
    if self.user_id.nil?
      self.user_id = self.current_user
    end

    if self.collected_on_day.blank? or self.collected_on_month.blank? or self.collected_on_year.blank? or self.collected_on_day == 'UNKNOWN' or self.collected_on_month == 'UNKNOWN' or self.collected_on_year == 'UNKNOWN'
      self.date_collected = nil
    else
      self.date_collected = DateTime.strptime(self.collected_on_year + "/" + self.collected_on_month + "/" + self.collected_on_day, "%Y/%m/%d" )
    end

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
                                      :coordinate_system => self.coordinate_system,
                                      :format => self.type_lat_long)
  end

  def requires_coordinate_system?
    has_coordinates? &&
    self.geocoords.data_format == :utm
  end

  def has_coordinates?
    !self.latitude.blank? && !self.longitude.blank?
  end
  

  def to_label 
    if !organism.nil?  
      return "#{organism.organism_code}-#{organism_index}"
#    else
#      return "#{self.id} SID" 
    end
  end
end

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
#  coordinate_system            :string(255)   
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
