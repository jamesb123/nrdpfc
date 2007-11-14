# == Schema Information
#
# Table name: mhc_seqs
#
#  id         :integer(11)   not null, primary key
#  project_id :integer(11)   
#  locus      :string(255)   
#  allele     :string(255)   
#  sequence   :text          
#

class MhcSeq < ActiveRecord::Base
  belongs_to :sample
end
