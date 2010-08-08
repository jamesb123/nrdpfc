class SurveysController < ApplicationController
  layout "tabs"
  active_scaffold :surveys do |config|
    config.columns = [:survey_date, :survey_time, :interval, :latitude, :longitude,
    :event, :effort, :trip, :speed_min, :speed_max, :drift, :drift_dir, :sea_state, 
    :swell_min, :swell_max, :depth, :sst, :salinity, :boat, :boat_number, :net, :net_number,
    :obj_dir, :obj_dist, :comments, :weather, :observer_1, :observer_2, :observer_3]
  

    config.columns[:effort].tooltip = <<-END
    END
    
    config.columns[:trip].tooltip = <<-END
    END
    
    config.columns[:speed_min].tooltip = <<-END
    END
    
    config.columns[:speed_max].tooltip = <<-END
    END

    config.columns[:drift].tooltip = <<-END
    Boat speed during events with engine off
    END

    config.columns[:drift_dir].tooltip = <<-END
    Cardinal Direction of Drift
    END
 
    config.columns[:sea_state].tooltip = <<-END
    Beaufort Scale
    END

    config.columns[:swell_min].tooltip = <<-END
    minimum estimate of wave height (trough to crest) in cm
    END

    config.columns[:swell_max].tooltip = <<-END
    maximum estimate of wave height (trough to crest) in cm
    END

    config.columns[:sst].tooltip = <<-END
    sea surface temperature in degrees Celsius 
    END
    
    config.columns[:salinity].tooltip = <<-END
    Percent Salinity of Surface Water
    END
    
    config.columns[:boat].tooltip = <<-END
    Type Classification (e.g. baiya or trawler)
    END
    
    config.columns[:boat_number].tooltip = <<-END
    Number of the indicated classification of boats
    END
    
    config.columns[:net].tooltip = <<-END
    Type classification (e.g. hifly or trammel)
    END

  end
  include ApprovedDataOnly
  include ResultTableSharedMethods  
end
