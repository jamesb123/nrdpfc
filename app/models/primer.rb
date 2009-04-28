class Primer < ActiveRecord::Base
  
  belongs_to :locu
  include SecuritySets::AdminOnly

end
