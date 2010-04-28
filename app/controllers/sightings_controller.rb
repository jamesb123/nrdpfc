class SightingsController < ApplicationController
  layout "tabs"
  active_scaffold :sightings do |config|
    config.columns = [:sighting_date, :sighting_time, :survey_vessel, 
    :clear, :hazy, :clouds, :overcast, :glare, :sunny, :foggy, 
    :mainly_cloudy, :rain, :latitude, :longitude, :sighting_by,
    :speed_min, :speed_max, :bearing, :ss, :depth, :sst, :sal, :angle,
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
  end

end
