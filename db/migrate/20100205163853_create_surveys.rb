class CreateSurveys < ActiveRecord::Migration
  def self.up
   create_table "surveys", :force => true do |t|
    t.integer  "sighting_id"
    t.datetime "date"
    t.datetime "time"
    t.datetime "interval"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "event"
    t.string   "effort"
    t.float    "trip"
    t.float    "speed_min"
    t.float    "speed_max"
    t.float    "drift"
    t.string   "drift_dir"
    t.string   "sea_state"
    t.float    "swell_min"
    t.float    "swell_max"
    t.float    "depth"
    t.float    "sst"
    t.float    "salinity"
    t.string   "boat"
    t.float    "boat_number"
    t.string   "net"
    t.float    "net_number"
    t.string   "obj_dir"
    t.float    "obj_dist"
    t.string   "comments"
    t.string   "weather"
    t.string   "observer_1"
    t.string   "observer_2"
    t.string   "observer_3"
    t.timestamps
  end
  end

  def self.down
    drop_table :surveys
  end
  
end
