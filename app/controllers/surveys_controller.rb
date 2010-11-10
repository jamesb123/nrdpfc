class SurveysController < ApplicationController
  layout "tabs"
  active_scaffold :surveys do |config|
    config.columns = [:id, :survey_date, :survey_time, :interval, :latitude, :longitude, :distance,
    :event, :effort, :trip, :speed_min, :speed_max, :drift, :drift_dir, :sea_state, 
    :swell_min, :swell_max, :depth, :sst, :salinity, :boat, :boat_number, :net, :net_number,
    :obj_dir, :obj_dist, :comments, :weather, :observer_1, :observer_2, :observer_3]
  
    config.update.columns.exclude :id
    config.create.columns.exclude :id

    config.columns[:interval].tooltip = <<-END
    Event Duration in minutes
    END
    config.columns[:effort].tooltip = <<-END
    actively looking for dolphins, on or off
    END
    config.columns[:trip].tooltip = <<-END
    cumulative survey distance (km)
    END
    config.columns[:speed_min].tooltip = <<-END
    minimum boat speed during event in km/h
    END
    config.columns[:speed_max].tooltip = <<-END
    maximum boat speed during event in km/h
    END
    config.columns[:drift].tooltip = <<-END
    boat speed during events with engine off
    END
    config.columns[:drift_dir].tooltip = <<-END
    cardinal direction of drift
    END
    config.columns[:sea_state].tooltip = <<-END
    beaufort scale
    END
    config.columns[:swell_min].tooltip = <<-END
    minimum estimate of wave height (trough to crest) in cm
    END
    config.columns[:swell_max].tooltip = <<-END
    maximum estimate of wave height (trough to crest) in cm
    END
    config.columns[:depth].tooltip = <<-END
    in metres
    END
    config.columns[:sst].tooltip = <<-END
    sea surface temperature in degrees Celsius
    END
    config.columns[:salinity].tooltip = <<-END
    percent salinity of surface water
    END
    config.columns[:boat].tooltip = <<-END
    number of the indicated classification of boats
    END
    config.columns[:boat_number].tooltip = <<-END
    number of the indicated classification of boats
    END
    config.columns[:net].tooltip = <<-END
    Type classification (e.g. hifly or trammel)
    END
    config.columns[:net_number].tooltip = <<-END
    number of the indicated classification of nets
    END
    config.columns[:obj_dir].tooltip = <<-END
    direction of indicated objects 
    (boats and/or nets) relative to the survey vessel
    END
    config.columns[:obj_dist].tooltip = <<-END
    distance of indicated objects (boats and/or nets) from the survey vessel
    END

  end
  include ApprovedDataOnly
  include ResultTableSharedMethods  
end
