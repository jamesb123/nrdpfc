# == Schema Information
#
# Table name: extraction_methods
#
#  id                            :integer(11)   not null, primary key
#  extraction_method_name        :string(255)   
#  extraction_method_description :string(255)   
#

class ExtractionMethod < ActiveRecord::Base
  has_many :samples
  
  extend Exportables::ExportableModel
  include SecuritySets::AllowAll
  
  def to_label 
    "#{extraction_method_name}" 
  end

end
