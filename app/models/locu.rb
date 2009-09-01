class Locu < ActiveRecord::Base
  has_many :microsatellites
  has_many :genders
  has_many :y_chromosomes
  has_many :mt_dnas
  has_many :mhcs
  has_many :primers
  belongs_to :project
  
  include SecuritySets::AdminOnly

  before_create :assign_project_id

  validates_format_of :locus, :with => /^[a-z0-9_]+$/i
  
# plugin file column
  file_column :pdf_name
  
  def to_label 
    "#{locus}" 
  end
  def assign_project_id
    self.project_id = current_project_id
  end 
end
