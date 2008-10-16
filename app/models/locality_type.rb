# == Schema Information
#
# Table name: locality_types
#
#  id                 :integer(11)   not null, primary key
#  locality_type_name :string(255)   
#  locality_type_desc :string(255)   
#

class LocalityType < ActiveRecord::Base
  
  has_many :samples
  extend Exportables::ExportableModel
  include SecuritySets::AllowAll
  
  def to_label
    "#{locality_type_name}"
  end
end
