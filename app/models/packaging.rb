class Packaging < ActiveRecord::Base
  include SecuritySets::AllowAll
  
  def to_label
    "#{medium_short_desc}"
  end
end
