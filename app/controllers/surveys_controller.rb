class SurveysController < ApplicationController
  layout "tabs"
  active_scaffold :surveys do |config|
    config.columns = [:survey_date, :survey_time, :interval, :latitude, :longitude,
    :event, :effort, :trip, :speed_min, :speed_max, :drift, :drift_dir, :sea_state, 
    :swell_min, :swell_max, :depth, :sst, :salinity, :boat, :boat_number, :net, :net_number,
    :obj_dir, :obj_dist, :comments, :weather, :observer_1, :observer_2, :observer_3]
  end
  include ApprovedDataOnly
  include ResultTableSharedMethods  
end
