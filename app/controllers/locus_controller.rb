class LocusController < ApplicationController
  layout "tabs"
 
  active_scaffold :locus do |config|
    config.columns = [:locus, :region, :marker, :conditions_data, :pdf_name]
  end

end
