# == Schema Information
#
# Table name: tissue_types
#
#  id          :integer(11)   not null, primary key
#  tissue_type :string(255)   
#  comment     :string(255)   
#

class TissueType < ActiveRecord::Base
  include SecuritySets::AllowAll
  
  has_many :samples

  def to_label
    "#{tissue_type}"
  end

end
