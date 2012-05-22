class Ssample < ActiveRecord::Base
  set_table_name 'samples'
  set_primary_key 'id'

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
  
  def to_label 
    if !organism.nil?  
      return "#{organism.organism_code} - #{organism_index}"
    else
      return "#{self.id} SID" 
    end
  end
end
