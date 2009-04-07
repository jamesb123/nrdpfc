class Locu < ActiveRecord::Base
  has_many :microsatellites
  has_many :primers
  include SecuritySets::AdminOnly
  def to_label 
    "#{locus}" 
  end
 
end
