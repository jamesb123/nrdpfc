class PrimersController < ApplicationController
  layout "tabs"  
  active_scaffold :primers do |config|
    config.columns = [:primer, :locu, :label, :locus_text, :paper_reference, :primer_sequence, :comments, :date_primer_ordered, :company, :lot_number, :date_primer_received, :room, :freezer, :box_number, :box_type, :lane_inactive, :lane_active, :entered_by, :stock_conc, :alquot_conc]
    
    config.columns[:locu].form_ui = :select

    config.columns[:locu].label = "Locus"
    config.columns[:locus_text].label = "Locus Text Description"
 
  end
 
end
