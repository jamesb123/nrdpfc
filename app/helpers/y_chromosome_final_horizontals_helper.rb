module YChromosomeFinalHorizontalsHelper
  def raw_data_column(record)
    link_to_modal("Raw Data", 
      {:controller => "/y_chromosomes", :action => "list", :organism_id => record.organism_id, :finalResult => true },
      { :width => 700, :height => 500 }
      )
  end
end
