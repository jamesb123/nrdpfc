# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 33) do

  create_table "country_orig", :force => true do |t|
  end

  create_table "dna_results", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.integer "prep_number"
    t.integer "extraction_number"
    t.string  "barcode"
    t.string  "plate"
    t.string  "position"
    t.string  "extraction_method"
    t.date    "extraction_date"
    t.string  "extractor"
    t.string  "extractor_comments"
    t.float   "fluoro_conc"
    t.float   "functional_conc"
    t.float   "pico_green_conc"
    t.string  "storage_building"
    t.string  "storage_room"
    t.string  "storage_freezer"
    t.string  "storage_box"
    t.string  "xy_position"
    t.boolean "dna_remaining"
  end

  create_table "dynamic_attribute_values", :force => true do |t|
    t.integer  "dynamic_attribute_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.integer  "integer_value"
    t.integer  "float_value",          :limit => 10, :precision => 10, :scale => 0
    t.text     "text_value"
    t.date     "date_value"
    t.datetime "timestamp_value"
  end

  add_index "dynamic_attribute_values", ["dynamic_attribute_id"], :name => "index_dynamic_attribute_values_on_dynamic_attribute_id"
  add_index "dynamic_attribute_values", ["owner_id"], :name => "index_dynamic_attribute_values_on_owner_id"
  add_index "dynamic_attribute_values", ["owner_type"], :name => "index_dynamic_attribute_values_on_owner_type"
  add_index "dynamic_attribute_values", ["owner_type", "owner_id"], :name => "index_dynamic_attribute_values_on_owner_type_and_owner_id"

  create_table "dynamic_attributes", :force => true do |t|
    t.string  "name"
    t.integer "dynamic_type_id"
    t.integer "dynamic_class_id"
    t.string  "scoper_type"
    t.integer "scoper_id"
    t.string  "owner_type"
  end

  add_index "dynamic_attributes", ["name"], :name => "index_dynamic_attributes_on_name"
  add_index "dynamic_attributes", ["dynamic_type_id"], :name => "index_dynamic_attributes_on_dynamic_type_id"
  add_index "dynamic_attributes", ["dynamic_class_id"], :name => "index_dynamic_attributes_on_dynamic_class_id"
  add_index "dynamic_attributes", ["owner_type"], :name => "index_dynamic_attributes_on_owner_type"

  create_table "dynamic_classes", :force => true do |t|
    t.string "name"
  end

  add_index "dynamic_classes", ["name"], :name => "index_dynamic_classes_on_name"

  create_table "dynamic_types", :force => true do |t|
    t.string "name"
    t.string "stored_in_field"
    t.string "description"
  end

  add_index "dynamic_types", ["name"], :name => "index_dynamic_types_on_name"

  create_table "extraction_methods", :force => true do |t|
    t.string "extraction_method_name"
    t.string "extraction_method_description"
  end

  create_table "genders", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "gender"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
    t.string  "locus"
  end

  create_table "locality_types", :force => true do |t|
    t.string "locality_type_name"
    t.string "locality_type_desc"
  end

  create_table "mhc_final_horizontals", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.integer  "organism_code"
    t.integer  "allelea"
    t.integer  "alleleb"
    t.integer  "extraction_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mhc_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.integer "extraction_number"
  end

  create_table "mhc_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele"
    t.text    "sequence"
  end

  create_table "mhcs", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele1"
    t.string  "allele2"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
  end

  create_table "microsatellite_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.integer "organism_code"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.integer "extraction_number"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW18a"
    t.integer "RW18b"
    t.integer "RW212a"
    t.integer "RW212b"
    t.integer "RW217a"
    t.integer "RW217b"
    t.integer "RW219a"
    t.integer "RW219b"
    t.integer "RW25a"
    t.integer "RW25b"
    t.integer "RW31a"
    t.integer "RW31b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "RW45a"
    t.integer "RW45b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "SAM25a"
    t.integer "SAM25b"
    t.integer "TR2F3a"
    t.integer "TR2F3b"
    t.integer "TR2G5a"
    t.integer "TR2G5b"
    t.integer "TR3A1a"
    t.integer "TR3A1b"
    t.integer "TR3F2a"
    t.integer "TR3F2b"
    t.integer "TR3F7a"
    t.integer "TR3F7b"
    t.integer "TR3G1a"
    t.integer "TR3G1b"
    t.integer "TR3G10a"
    t.integer "TR3G10b"
    t.integer "TR3G11a"
    t.integer "TR3G11b"
    t.integer "TR3G13a"
    t.integer "TR3G13b"
    t.integer "TR3G2a"
    t.integer "TR3G2b"
    t.integer "TR3G5a"
    t.integer "TR3G5b"
    t.integer "TR3G6a"
    t.integer "TR3G6b"
    t.integer "TR3H14a"
    t.integer "TR3H14b"
    t.integer "TR3H4a"
    t.integer "TR3H4b"
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  create_table "microsatellite_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.integer "extraction_number"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW18a"
    t.integer "RW18b"
    t.integer "RW212a"
    t.integer "RW212b"
    t.integer "RW217a"
    t.integer "RW217b"
    t.integer "RW219a"
    t.integer "RW219b"
    t.integer "RW25a"
    t.integer "RW25b"
    t.integer "RW31a"
    t.integer "RW31b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "RW45a"
    t.integer "RW45b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "SAM25a"
    t.integer "SAM25b"
    t.integer "TR2F3a"
    t.integer "TR2F3b"
    t.integer "TR2G5a"
    t.integer "TR2G5b"
    t.integer "TR3A1a"
    t.integer "TR3A1b"
    t.integer "TR3F2a"
    t.integer "TR3F2b"
    t.integer "TR3F7a"
    t.integer "TR3F7b"
    t.integer "TR3G1a"
    t.integer "TR3G1b"
    t.integer "TR3G10a"
    t.integer "TR3G10b"
    t.integer "TR3G11a"
    t.integer "TR3G11b"
    t.integer "TR3G13a"
    t.integer "TR3G13b"
    t.integer "TR3G2a"
    t.integer "TR3G2b"
    t.integer "TR3G5a"
    t.integer "TR3G5b"
    t.integer "TR3G6a"
    t.integer "TR3G6b"
    t.integer "TR3H14a"
    t.integer "TR3H14b"
    t.integer "TR3H4a"
    t.integer "TR3H4b"
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  create_table "microsatellite_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_code"
    t.integer "org_sample"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_code"
    t.integer "org_sample"
    t.integer "extraction_number"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW18a"
    t.integer "RW18b"
    t.integer "RW212a"
    t.integer "RW212b"
    t.integer "RW217a"
    t.integer "RW217b"
    t.integer "RW219a"
    t.integer "RW219b"
    t.integer "RW25a"
    t.integer "RW25b"
    t.integer "RW31a"
    t.integer "RW31b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "RW45a"
    t.integer "RW45b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "SAM25a"
    t.integer "SAM25b"
    t.integer "TR2F3a"
    t.integer "TR2F3b"
    t.integer "TR2G5a"
    t.integer "TR2G5b"
    t.integer "TR3A1a"
    t.integer "TR3A1b"
    t.integer "TR3F2a"
    t.integer "TR3F2b"
    t.integer "TR3F7a"
    t.integer "TR3F7b"
    t.integer "TR3G1a"
    t.integer "TR3G1b"
    t.integer "TR3G10a"
    t.integer "TR3G10b"
    t.integer "TR3G11a"
    t.integer "TR3G11b"
    t.integer "TR3G13a"
    t.integer "TR3G13b"
    t.integer "TR3G2a"
    t.integer "TR3G2b"
    t.integer "TR3G5a"
    t.integer "TR3G5b"
    t.integer "TR3G6a"
    t.integer "TR3G6b"
    t.integer "TR3H14a"
    t.integer "TR3H14b"
    t.integer "TR3H4a"
    t.integer "TR3H4b"
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  create_table "microsatellite_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_code"
    t.integer "org_sample"
    t.integer "extraction_number"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW18a"
    t.integer "RW18b"
    t.integer "RW212a"
    t.integer "RW212b"
    t.integer "RW217a"
    t.integer "RW217b"
    t.integer "RW219a"
    t.integer "RW219b"
    t.integer "RW25a"
    t.integer "RW25b"
    t.integer "RW31a"
    t.integer "RW31b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "RW45a"
    t.integer "RW45b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "SAM25a"
    t.integer "SAM25b"
    t.integer "TR2F3a"
    t.integer "TR2F3b"
    t.integer "TR2G5a"
    t.integer "TR2G5b"
    t.integer "TR3A1a"
    t.integer "TR3A1b"
    t.integer "TR3F2a"
    t.integer "TR3F2b"
    t.integer "TR3F7a"
    t.integer "TR3F7b"
    t.integer "TR3G1a"
    t.integer "TR3G1b"
    t.integer "TR3G10a"
    t.integer "TR3G10b"
    t.integer "TR3G11a"
    t.integer "TR3G11b"
    t.integer "TR3G13a"
    t.integer "TR3G13b"
    t.integer "TR3G2a"
    t.integer "TR3G2b"
    t.integer "TR3G5a"
    t.integer "TR3G5b"
    t.integer "TR3G6a"
    t.integer "TR3G6b"
    t.integer "TR3H14a"
    t.integer "TR3H14b"
    t.integer "TR3H4a"
    t.integer "TR3H4b"
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  create_table "microsatellites", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele1"
    t.string  "allele2"
    t.string  "gel"
    t.string  "well"
    t.boolean "finalResult"
  end

  add_index "microsatellites", ["sample_id", "project_id", "locus"], :name => "Index_2"
  add_index "microsatellites", ["locus"], :name => "index_microsatellites_on_locus"
  add_index "microsatellites", ["allele1"], :name => "index_microsatellites_on_allele1"
  add_index "microsatellites", ["allele2"], :name => "index_microsatellites_on_allele2"
  add_index "microsatellites", ["finalResult"], :name => "index_microsatellites_on_finalResult"

  create_table "mt_dna_final_horizontals", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.integer  "organism_code"
    t.integer  "haplotype"
    t.integer  "extraction_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mt_dna_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.integer "extraction_number"
    t.integer "Control Region"
  end

  create_table "mt_dna_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.text    "sequence"
  end

  create_table "mt_dnas", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
  end

  create_table "organisms", :force => true do |t|
    t.integer "project_id"
    t.string  "organism_code"
    t.string  "comment"
  end

  create_table "projects", :force => true do |t|
    t.string  "name"
    t.string  "code"
    t.string  "description"
    t.integer "user_id"
    t.boolean "recompile_required"
  end

  create_table "province_state_orig", :primary_key => "PROVINCE_STATE_PK", :force => true do |t|
    t.string  "PROVINCE_STATE_DESC", :limit => 30
    t.integer "COUNTRY_FK"
  end

  add_index "province_state_orig", ["COUNTRY_FK"], :name => "COUNTRY_CODE"
  add_index "province_state_orig", ["COUNTRY_FK"], :name => "CountryProvince_State"

  create_table "sample_non_tissues", :force => true do |t|
    t.integer "organism_id"
    t.integer "project_id"
    t.string  "field_code"
    t.string  "prov"
    t.string  "country"
    t.date    "date_collected"
    t.string  "collected_by"
    t.string  "submitted_by"
    t.date    "date_submitted"
    t.text    "submitter_comments"
    t.string  "received_by"
    t.date    "date_received"
    t.text    "receiver_comments"
    t.float   "latitude"
    t.float   "longitude"
    t.float   "UTM_datum"
    t.string  "locality"
    t.string  "locality_type"
    t.string  "locality_comments"
    t.string  "location_accuracy"
    t.string  "type_lat_long"
  end

  create_table "samples", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.string   "organism_code"
    t.string   "org_sample"
    t.string   "tubebc"
    t.string   "platebc"
    t.string   "plateposition"
    t.string   "field_code"
    t.string   "batch_number"
    t.string   "tissue_type"
    t.string   "storage_medium"
    t.string   "country"
    t.string   "province"
    t.datetime "date_collected"
    t.integer  "collected_on_day"
    t.integer  "collected_on_month"
    t.integer  "collected_on_year"
    t.string   "collected_by"
    t.datetime "date_received"
    t.string   "received_by"
    t.text     "receiver_comments"
    t.datetime "date_submitted"
    t.string   "submitted_by"
    t.text     "submitter_comments"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "UTM_datum"
    t.string   "locality"
    t.string   "locality_type"
    t.string   "locality_comments"
    t.string   "location_accuracy"
    t.string   "storage_building"
    t.string   "storage_room"
    t.string   "storage_fridge"
    t.string   "storage_box"
    t.string   "xy_position"
    t.boolean  "tissue_remaining"
    t.string   "type_lat_long"
    t.integer  "locality_type_id"
    t.integer  "shippingmaterial_id"
    t.integer  "tissue_type_id"
    t.integer  "province_id"
    t.integer  "storage_medium_id"
    t.integer  "country_id"
    t.integer  "extraction_method_id"
  end

  add_index "samples", ["organism_id"], :name => "index_samples_on_organism_id"
  add_index "samples", ["organism_code"], :name => "index_samples_on_organism_code"
  add_index "samples", ["project_id"], :name => "index_samples_on_project_id"

  create_table "security_settings", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "level",      :default => 0
  end

  add_index "security_settings", ["project_id"], :name => "index_security_settings_on_project_id"
  add_index "security_settings", ["user_id"], :name => "index_security_settings_on_user_id"

  create_table "shippingmaterials", :force => true do |t|
    t.string "medium_short_desc"
    t.string "medium_long_desc"
  end

  create_table "tissue_types", :force => true do |t|
    t.string "tissue_type"
    t.string "comment"
  end

  create_table "users", :force => true do |t|
    t.integer  "project_id"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "y_chromosome_final_horizontals", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.integer  "organism_code"
    t.integer  "haplotype"
    t.integer  "extraction_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "y_chromosome_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.integer "extraction_number"
  end

  create_table "y_chromosome_seqs", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.text    "sequence"
  end

  create_table "y_chromosomes", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
  end

end
