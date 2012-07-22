class Locu < ActiveRecord::Base
  has_many :microsatellites
  has_many :genders
  has_many :y_chromosomes
  has_many :mt_dnas
  has_many :mhcs
  has_many :primers
  has_many :mt_dna_seqs
  
  include SecuritySets::AdminOnly
  include ProjectRelations

#  validates_format_of :locus, :with => /^[a-z0-9_]+$/i
  
# plugin file column
  file_column :pdf_name
  
  def to_label 
    "#{locus}" 
  end
end
