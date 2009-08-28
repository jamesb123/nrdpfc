class LocusController < ApplicationController
  layout "tabs"
 
  active_scaffold :locus do |config|
    config.columns = [:locus, :region, :marker, :test_name, :conditions_data, :pdf_name]
    config.nested.add_link("Primers", [:primers])
    config.columns[:test_name].form_ui = :select

  end
  def conditions_for_collection
    ['locus.project_id = (?)', current_project_id ]
  end
end
