class Locus < ActiveRecord::Base
  belongs_to :sample
  has_many :primers
  
end
