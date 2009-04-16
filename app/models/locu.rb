class Locu < ActiveRecord::Base
  has_many :microsatellites
  has_many :genders
  has_many :y_chromosomes
  has_many :mt_dnas
  has_many :mhcs
  has_many :primers
  
  extend Exportables::ExportableModel
  include SecuritySets::AdminOnly
  
  def to_label 
    "#{locus}" 
  end
 
end
