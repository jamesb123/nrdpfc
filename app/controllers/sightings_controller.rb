class SightingsController < ApplicationController
  layout "tabs"
  active_scaffold :sightings do |config|
    config.columns = [:id, :sighting_date, :sighting_time, :survey_vessel, 
    :clear, :hazy, :clouds, :overcast, :glare, :sunny, :foggy, 
    :mainly_cloudy, :rain, :latitude, :longitude, :distance, :sighting_by,
    :speed_min, :speed_max, :bearing, :sea_state, :depth, :sst, :salinity, :angle,
    :dist, :group_max, :group_min, :group_best, :mother_calf_pairs, :dist_min, :dolphin_speed, 
    :group_comments, :logging, :slow_swim, :fast_swim, :porpoising, :chasing, 
    :breaching, :surfing, :fluke_up, :back_arch, :bow_ride, :stern_ride,
    :synch, :mostly_synch, :asynch, :unidir, :mostly_unidir, :multidir,
    :loose_group, :adult_pairs, :subgroups, :tight_group, :structure_comments, :resting,
    :travelling, :feeding, :play, :mating_sexual, :aggression, :prey_mouth, :prey_water,
    :prey_fleeing, :prey_sonar, :driftnet, :sink_gillnets, :trawl, :pole_fishing, :commercial,
    :vessel_comments, :assoc_fish, :assoc_seabirds, :assoc_upwell, :assoc_weed, :assoc_debris,
    :association_comments, :sonar, :scy_cam, :photo_comments, :general_comments, :id_number,
    :id_text, :id_comments]
    config.update.columns.exclude :id
    config.create.columns.exclude :id
    
    config.columns[:structure_comments].options = { :cols => 100, :rows => 1 }
    config.columns[:sighting_date].options[:format] = "%d-%b-%Y"
    config.columns[:sighting_time].options[:format] = "%H:%M:%S"
    config.columns[:clear].form_ui = :checkbox
    config.columns[:hazy].form_ui = :checkbox
    config.columns[:clouds].form_ui = :checkbox
    config.columns[:overcast].form_ui = :checkbox
    config.columns[:glare].form_ui = :checkbox
    config.columns[:sunny].form_ui = :checkbox
    config.columns[:foggy].form_ui = :checkbox
    config.columns[:mainly_cloudy].form_ui = :checkbox
    config.columns[:rain].form_ui = :checkbox
    config.columns[:logging].form_ui = :checkbox
    config.columns[:slow_swim].form_ui = :checkbox
    config.columns[:fast_swim].form_ui = :checkbox
    config.columns[:porpoising].form_ui = :checkbox
    config.columns[:chasing].form_ui = :checkbox
    config.columns[:breaching].form_ui = :checkbox
    config.columns[:surfing].form_ui = :checkbox
    config.columns[:fluke_up].form_ui = :checkbox
    config.columns[:back_arch].form_ui = :checkbox
    config.columns[:bow_ride].form_ui = :checkbox
    config.columns[:stern_ride].form_ui = :checkbox
    config.columns[:synch].form_ui = :checkbox
    config.columns[:mostly_synch].form_ui = :checkbox
    config.columns[:asynch].form_ui = :checkbox
    config.columns[:unidir].form_ui = :checkbox
    config.columns[:mostly_unidir].form_ui = :checkbox
    config.columns[:multidir].form_ui = :checkbox
    config.columns[:loose_group].form_ui = :checkbox
    config.columns[:adult_pairs].form_ui = :checkbox
    config.columns[:subgroups].form_ui = :checkbox
    config.columns[:resting].form_ui = :checkbox
    config.columns[:travelling].form_ui = :checkbox
    config.columns[:feeding].form_ui = :checkbox
    config.columns[:play].form_ui = :checkbox
    config.columns[:mating_sexual].form_ui = :checkbox
    config.columns[:aggression].form_ui = :checkbox
    config.columns[:prey_mouth].form_ui = :checkbox
    config.columns[:prey_water].form_ui = :checkbox
    config.columns[:prey_fleeing].form_ui = :checkbox
    config.columns[:prey_sonar].form_ui = :checkbox
    config.columns[:driftnet].form_ui = :checkbox
    config.columns[:sink_gillnets].form_ui = :checkbox
    config.columns[:trawl].form_ui = :checkbox
    config.columns[:pole_fishing].form_ui = :checkbox
    config.columns[:commercial].form_ui = :checkbox
    config.columns[:vessel_comments].form_ui = :checkbox
    config.columns[:assoc_fish].form_ui = :checkbox
    config.columns[:assoc_seabirds].form_ui = :checkbox
    config.columns[:assoc_upwell].form_ui = :checkbox
    config.columns[:assoc_debris].form_ui = :checkbox
    config.columns[:assoc_weed].form_ui = :checkbox
    config.columns[:sonar].form_ui = :checkbox
    config.columns[:tight_group].form_ui = :checkbox

    config.columns[:salinity].tooltip = <<-END
    percent salinity of surface water
    END
    config.columns[:sea_state].tooltip = <<-END
    beaufort scale
    END
    
    config.columns[:sst].tooltip = <<-END
    sea surface temperature in degrees Celsius
    END

    config.columns[:speed_min].tooltip = <<-END
    minimum boat speed during event in km/h
    END
    config.columns[:speed_max].tooltip = <<-END
    maximum boat speed during event in km/h
    END

    config.columns[:sighting_time].tooltip = <<-END
    24 Hour Format (HH:MM:SS)
    END
    config.columns[:bearing].tooltip = <<-END
    cardinal direction dolphins are heading
    END
    config.columns[:angle].tooltip = <<-END
    direction of dolphins relative to the survey vessel in degrees where the bow is 0 degrees
    END
    config.columns[:dist].tooltip = <<-END
    estimated distance of dolphins from survey vessel in metres
    END
    config.columns[:group_max].tooltip = <<-END
    maximum estimated number of observed dolphins
    END
    config.columns[:group_min].tooltip = <<-END
    minimum estimated number of observed dolphins
    END
    config.columns[:group_best].tooltip = <<-END
    best estimated number of observed dolphins
    END
    config.columns[:dist_min].tooltip = <<-END
    closest estimated approach of dolphins to survey vessel in metres
    END
    config.columns[:dolphin_speed].tooltip = <<-END
    estimated speed of dolphins in km/h
    END
    config.columns[:group_comments].tooltip = <<-END
    comments regarding group composition (e.g. 2 very pink, 1 neonate)
    END
    config.columns[:slow_swim].tooltip = <<-END
    indicated by wake absence
    END
    config.columns[:fast_swim].tooltip = <<-END
    indicated by wake presence
    END
    config.columns[:adult_pairs].tooltip = <<-END
    number of paired dolphins excluding mother-calf pairs
    END
    config.columns[:structure_comments].tooltip = <<-END
    comments regarding the group structure of observed dolphins
    END
    config.columns[:vessel_comments].tooltip = <<-END
    comments on vessels and/or nets observed during dolphin sighting
    END
    config.columns[:association_comments].tooltip = <<-END
    comments regarding observed dolphin association with other animals/objects/features
    END
    config.columns[:sonar].tooltip = <<-END
    relative amount of activity observed on sonar
    END
    config.columns[:scy_cam].tooltip = <<-END
    help field - camera model used by Shih-Chu Yang
    END
  end
    
  include ApprovedDataOnly
  include ResultTableSharedMethods  

end
