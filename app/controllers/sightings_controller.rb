class SightingsController < ApplicationController
  layout "tabs"
  active_scaffold :sightings do |config|
    config.columns = [:date, :time, :vessel,

    :Clear, :Hazy, :Clouds, :Overcast, :Glare, :Sunny, :Foggy, 
    :Mainly_cloudy, :Rain, :Latitude, :Longitude, :Sighting_By,
    :Speed_min, :Speed_max, :Bearing, :SS, :Depth, :SST, :Sal, :Angle,
    :Dist, :High, :Low, :Best, :M_C, :"Closest", :"Dspeed", :"group comments",
    :"Logging", :"Slow (no wake)", :"Fast (wake)", :"Porpoising", :"Chasing", 
    :"Breaching", :"Surfing", :"Fluke_up", :"High back arch", :"Bow", :"Stern",
    :"Synch", :"Mostly_synch", :"Asynch", :"Unidir", :"Mostly Unidir", :"Multidir",
    :"Loose", :"Pairs_exc_MC)"
    :    "Subgroups"
    :    "Tight"
    :   "structure comments"
    :    "Resting"
    :    "Travelling"
    :    "Feeding"
    :    "Play"
    :    "Mating/Sexual"
    :    "Aggression"
    :    "Prey in mouth"
    :    "Prey in water"
    :    "Prey observed fleeing"
    :    "Prey on sonar"
    :    "Driftnet"
    :    "Sink gillnets"
    :    "Trawl"
    :    "Pole-fishing"
    :    "Commercial"
    :   "Vessel comments"
    :    "Fish"
    :    "Seabirds"
    :    "Upwelling"
    :    "Weed"
    :    "Debris streak"
    :   "association comments"
    :   "Sonar"
    :   "SCY"
    :   "Colour_Letter_Code"
    :   "general comments"
    :    "ID_number"
    :   "ID_text"
    :   "ID_comments"
     
    
  end
end
