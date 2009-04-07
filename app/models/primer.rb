class Primer < ActiveRecord::Base
  
  belongs_to :locus
  include SecuritySets::AdminOnly
  
end
