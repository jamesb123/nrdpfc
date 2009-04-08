class LocusController < ApplicationController
  layout "tabs"
 
  active_scaffold :locus do |config|
    config.columns = [:locus, :region, :marker, :conditions_data, :pdf_name]
    config.nested.add_link("Primers", [:primers])

  end

end
