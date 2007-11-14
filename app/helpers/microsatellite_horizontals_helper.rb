module MicrosatelliteHorizontalsHelper
  def raw_data_column(record)
    link_to_modal("Raw Data", 
      {:controller => "/microsatellites", :action => "list", :sample_id => record.sample_id },
      { :width => 700, :height => 500 }
      )
  end
end
