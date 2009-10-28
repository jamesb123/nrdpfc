# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091027174056) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "province"
    t.string   "postal"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.string   "email"
    t.string   "payment_method"
    t.string   "credit_card"
    t.string   "purchase_order"
    t.string   "overdue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  create_table "country_orig", :force => true do |t|
  end

  create_table "data_queries", :force => true do |t|
    t.text     "data"
    t.integer  "project_id"
    t.string   "access_key"
    t.datetime "accessed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.text    "comments"
    t.integer "extraction_method_id"
    t.boolean "approved",             :default => false
  end

  add_index "dna_results", ["project_id"], :name => "index_dna_results_on_project_id"
  add_index "dna_results", ["approved"], :name => "index_dna_results_on_approved"

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

  create_table "gender_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "gender"
  end

  create_table "gender_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "RW34"
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_1", ["organism_id"], :name => "index_gender_final_horizontals_1_on_organism_id"

  create_table "gender_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "gender_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_17", ["organism_id"], :name => "index_gender_final_horizontals_17_on_organism_id"

  create_table "gender_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_2", ["organism_id"], :name => "index_gender_final_horizontals_2_on_organism_id"

  create_table "gender_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1"
  end

  create_table "gender_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "gender_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "gender_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "gender_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1"
  end

  create_table "gender_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "gender_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1"
  end

  create_table "genders", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "gender"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
    t.string  "locus"
    t.text    "comments"
    t.integer "locu_id"
    t.boolean "approved",    :default => false
  end

  add_index "genders", ["finalResult"], :name => "index_genders_on_finalResult"
  add_index "genders", ["project_id"], :name => "index_genders_on_project_id"
  add_index "genders", ["approved"], :name => "index_genders_on_approved"

  create_table "locality_types", :force => true do |t|
    t.string "locality_type_name"
    t.string "locality_type_desc"
  end

  create_table "locus", :force => true do |t|
    t.string   "locus"
    t.string   "region"
    t.string   "marker"
    t.string   "conditions_data"
    t.string   "pdf_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "test_name"
  end

  create_table "mhc_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "mhc_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "TR2G5a"
    t.string  "TR2G5b"
  end

  add_index "mhc_final_horizontals_1", ["organism_id"], :name => "index_mhc_final_horizontals_1_on_organism_id"

  create_table "mhc_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "mhc_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknowna"
    t.string  "Unknownb"
  end

  add_index "mhc_final_horizontals_17", ["organism_id"], :name => "index_mhc_final_horizontals_17_on_organism_id"

  create_table "mhc_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_2", ["organism_id"], :name => "index_mhc_final_horizontals_2_on_organism_id"

  create_table "mhc_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "aa"
    t.string  "ab"
    t.string  "socola"
    t.string  "socolb"
  end

  create_table "mhc_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "mhc_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "mhc_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "mhc_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1a"
    t.string  "1b"
    t.string  "aa"
    t.string  "ab"
    t.string  "socola"
    t.string  "socolb"
  end

  create_table "mhc_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "mhc_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1a"
    t.string  "1b"
    t.string  "aa"
    t.string  "ab"
    t.string  "socola"
    t.string  "socolb"
  end

  create_table "mhc_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
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
    t.text    "comments"
    t.integer "locu_id"
    t.boolean "approved",    :default => false
  end

  add_index "mhcs", ["finalResult"], :name => "index_mhcs_on_finalResult"
  add_index "mhcs", ["project_id"], :name => "index_mhcs_on_project_id"
  add_index "mhcs", ["approved"], :name => "index_mhcs_on_approved"

  create_table "microsatellite_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "testa"
    t.integer "testb"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_1", ["organism_id"], :name => "index_microsatellite_final_horizontals_1_on_organism_id"

  create_table "microsatellite_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "PLO-M15a"
    t.integer "PLO-M15b"
    t.integer "PLO-M17a"
    t.integer "PLO-M17b"
    t.integer "PLO-M2a"
    t.integer "PLO-M2b"
    t.integer "PLO-M20a"
    t.integer "PLO-M20b"
    t.integer "PLO-M3a"
    t.integer "PLO-M3b"
    t.integer "PLO2-117a"
    t.integer "PLO2-117b"
    t.integer "PLO2-123a"
    t.integer "PLO2-123b"
    t.integer "PLO2-14a"
    t.integer "PLO2-14b"
    t.integer "PLO3-117a"
    t.integer "PLO3-117b"
    t.integer "PLO3-71a"
    t.integer "PLO3-71b"
    t.integer "PLO3-86a"
    t.integer "PLO3-86b"
    t.integer "ZFX/Ya"
    t.integer "ZFX/Yb"
  end

  create_table "microsatellite_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "MK6a"
    t.integer "MK6b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV2a"
    t.integer "TV2b"
    t.integer "TV5a"
    t.integer "TV5b"
  end

  create_table "microsatellite_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_17", ["organism_id"], :name => "index_microsatellite_final_horizontals_17_on_organism_id"

  create_table "microsatellite_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",       :limit => 128
    t.integer "ZFX/ZFYa"
    t.integer "ZFX/ZFYb"
    t.integer "Egl_Control_Regiona"
    t.integer "Egl_Control_Regionb"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_2", ["organism_id"], :name => "index_microsatellite_final_horizontals_2_on_organism_id"

  create_table "microsatellite_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "-1a"
    t.integer "-1b"
    t.integer "Meatballa"
    t.integer "Meatballb"
    t.integer "Noodlea"
    t.integer "Noodleb"
    t.integer "nulla"
    t.integer "nullb"
    t.integer "zeroa"
    t.integer "zerob"
  end

  create_table "microsatellite_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Ms10a"
    t.integer "Ms10b"
    t.integer "Ms11a"
    t.integer "Ms11b"
    t.integer "Ms14a"
    t.integer "Ms14b"
    t.integer "Ms3a"
    t.integer "Ms3b"
    t.integer "Ms4a"
    t.integer "Ms4b"
    t.integer "Ms8a"
    t.integer "Ms8b"
  end

  create_table "microsatellite_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
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
    t.integer "Ms10a"
    t.integer "Ms10b"
    t.integer "Ms11a"
    t.integer "Ms11b"
    t.integer "Ms14a"
    t.integer "Ms14b"
    t.integer "Ms3a"
    t.integer "Ms3b"
    t.integer "Ms4a"
    t.integer "Ms4b"
    t.integer "Ms8a"
    t.integer "Ms8b"
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

  create_table "microsatellite_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "microsatellite_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "1a"
    t.integer "1b"
  end

  create_table "microsatellite_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "172a"
    t.integer "172b"
    t.integer "200a"
    t.integer "200b"
    t.integer "204a"
    t.integer "204b"
    t.integer "225a"
    t.integer "225b"
    t.integer "250a"
    t.integer "250b"
    t.integer "377a"
    t.integer "377b"
  end

  create_table "microsatellite_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "2a"
    t.integer "2b"
  end

  create_table "microsatellite_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.string  "organism_code"
    t.integer "org_sample"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "testa"
    t.integer "testb"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_1", ["sample_id"], :name => "index_microsatellite_horizontals_1_on_sample_id"

  create_table "microsatellite_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "PLO-M15a"
    t.integer "PLO-M15b"
    t.integer "PLO-M17a"
    t.integer "PLO-M17b"
    t.integer "PLO-M2a"
    t.integer "PLO-M2b"
    t.integer "PLO-M20a"
    t.integer "PLO-M20b"
    t.integer "PLO-M3a"
    t.integer "PLO-M3b"
    t.integer "PLO2-117a"
    t.integer "PLO2-117b"
    t.integer "PLO2-123a"
    t.integer "PLO2-123b"
    t.integer "PLO2-14a"
    t.integer "PLO2-14b"
    t.integer "PLO3-117a"
    t.integer "PLO3-117b"
    t.integer "PLO3-71a"
    t.integer "PLO3-71b"
    t.integer "PLO3-86a"
    t.integer "PLO3-86b"
    t.integer "ZFX/Ya"
    t.integer "ZFX/Yb"
  end

  create_table "microsatellite_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "MK6a"
    t.integer "MK6b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV2a"
    t.integer "TV2b"
    t.integer "TV5a"
    t.integer "TV5b"
  end

  create_table "microsatellite_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_17", ["sample_id"], :name => "index_microsatellite_horizontals_17_on_sample_id"

  create_table "microsatellite_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "ZFX/ZFYa"
    t.integer "ZFX/ZFYb"
    t.integer "Egl_Control_Regiona"
    t.integer "Egl_Control_Regionb"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_2", ["sample_id"], :name => "index_microsatellite_horizontals_2_on_sample_id"

  create_table "microsatellite_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "-1a"
    t.integer "-1b"
    t.integer "Meatballa"
    t.integer "Meatballb"
    t.integer "Noodlea"
    t.integer "Noodleb"
    t.integer "nulla"
    t.integer "nullb"
    t.integer "zeroa"
    t.integer "zerob"
  end

  create_table "microsatellite_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Ms10a"
    t.integer "Ms10b"
    t.integer "Ms11a"
    t.integer "Ms11b"
    t.integer "Ms14a"
    t.integer "Ms14b"
    t.integer "Ms3a"
    t.integer "Ms3b"
    t.integer "Ms4a"
    t.integer "Ms4b"
    t.integer "Ms8a"
    t.integer "Ms8b"
  end

  create_table "microsatellite_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
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
    t.integer "Ms10a"
    t.integer "Ms10b"
    t.integer "Ms11a"
    t.integer "Ms11b"
    t.integer "Ms14a"
    t.integer "Ms14b"
    t.integer "Ms3a"
    t.integer "Ms3b"
    t.integer "Ms4a"
    t.integer "Ms4b"
    t.integer "Ms8a"
    t.integer "Ms8b"
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

  create_table "microsatellite_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  create_table "microsatellite_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "1a"
    t.integer "1b"
  end

  create_table "microsatellite_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "172a"
    t.integer "172b"
    t.integer "200a"
    t.integer "200b"
    t.integer "204a"
    t.integer "204b"
    t.integer "225a"
    t.integer "225b"
    t.integer "250a"
    t.integer "250b"
    t.integer "377a"
    t.integer "377b"
  end

  create_table "microsatellite_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "2a"
    t.integer "2b"
  end

  create_table "microsatellites", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus",                :limit => 30
    t.integer "allele1"
    t.integer "allele2"
    t.string  "gel"
    t.string  "well"
    t.boolean "finalResult"
    t.text    "comments"
    t.decimal "allele_1_peak_height",               :precision => 6, :scale => 2
    t.decimal "allele_2_peak_height",               :precision => 6, :scale => 2
    t.integer "locu_id"
    t.boolean "approved",                                                         :default => false
  end

  add_index "microsatellites", ["sample_id"], :name => "index_sample_id"
  add_index "microsatellites", ["project_id"], :name => "index_project_id"
  add_index "microsatellites", ["locus"], :name => "index_microsatellites_on_locus"
  add_index "microsatellites", ["allele1"], :name => "index_microsatellites_on_allele1"
  add_index "microsatellites", ["allele2"], :name => "index_microsatellites_on_allele2"
  add_index "microsatellites", ["finalResult"], :name => "index_microsatellites_on_finalResult"
  add_index "microsatellites", ["gel"], :name => "index_microsatellites_on_gel"
  add_index "microsatellites", ["well"], :name => "index_microsatellites_on_well"
  add_index "microsatellites", ["locu_id"], :name => "index_microsatellites_on_locu_id"
  add_index "microsatellites", ["approved"], :name => "index_microsatellites_on_approved"

  create_table "mt_dna_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "haplotype"
  end

  create_table "mt_dna_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "GT271"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_1", ["organism_id"], :name => "index_mt_dna_final_horizontals_1_on_organism_id"

  create_table "mt_dna_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "Control Region"
    t.string  "Control region, Yoshida et al. (2001)"
    t.string  "cytochrome b"
  end

  create_table "mt_dna_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_17", ["organism_id"], :name => "index_mt_dna_final_horizontals_17_on_organism_id"

  create_table "mt_dna_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_2", ["organism_id"], :name => "index_mt_dna_final_horizontals_2_on_organism_id"

  create_table "mt_dna_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "Control Region"
    t.string  "Control region, Yoshida et al. (2001)"
    t.string  "cytochrome b"
    t.string  "mtDNA"
  end

  create_table "mt_dna_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "cytochrome b"
  end

  create_table "mt_dna_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "cytochrome b"
  end

  create_table "mt_dna_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "cytochrome b"
  end

  create_table "mt_dna_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "1"
    t.string  "Control Region"
    t.string  "Control region, Yoshida et al. (2001)"
    t.string  "cytochrome b"
    t.string  "mtDNA"
  end

  create_table "mt_dna_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "cytochrome b"
  end

  create_table "mt_dna_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "1"
    t.string  "Control Region"
    t.string  "Control region, Yoshida et al. (2001)"
    t.string  "cytochrome b"
    t.string  "mtDNA"
  end

  create_table "mt_dna_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
  end

  add_index "mt_dna_seqs", ["project_id"], :name => "index_mt_dna_seqs_on_project_id"

  create_table "mt_dnas", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype",   :limit => 12
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
    t.text    "comments"
    t.integer "locu_id"
    t.boolean "approved",                  :default => false
  end

  add_index "mt_dnas", ["finalResult"], :name => "index_mt_dnas_on_finalResult"
  add_index "mt_dnas", ["project_id"], :name => "index_mt_dnas_on_project_id"
  add_index "mt_dnas", ["approved"], :name => "index_mt_dnas_on_approved"

  create_table "nats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisms", :force => true do |t|
    t.integer "project_id"
    t.string  "organism_code"
    t.string  "comment"
    t.boolean "approved",      :default => false
  end

  add_index "organisms", ["project_id"], :name => "index_organisms_on_project_id"
  add_index "organisms", ["approved"], :name => "index_organisms_on_approved"

  create_table "primers", :force => true do |t|
    t.integer "locu_id"
    t.string  "primer"
    t.string  "label"
    t.string  "locus_text"
    t.string  "paper_reference"
    t.string  "primer_sequence"
    t.string  "comments"
    t.date    "date_primer_ordered"
    t.string  "company"
    t.string  "lot_number"
    t.date    "date_primer_received"
    t.string  "room"
    t.string  "freezer"
    t.string  "box_number"
    t.string  "box_type"
    t.string  "lane_inactive"
    t.string  "lane_active"
    t.string  "entered_by"
    t.integer "stock_conc"
    t.integer "alquot_conc"
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

  create_table "queries", :force => true do |t|
    t.integer  "project_id"
    t.string   "name",       :limit => 100
    t.boolean  "draft",                     :default => true
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "short_role"
    t.string "long_role"
  end

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

  add_index "sample_non_tissues", ["project_id"], :name => "index_sample_non_tissues_on_project_id"

  create_table "samples", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.integer  "organism_index"
    t.string   "field_code"
    t.string   "sample_bc"
    t.string   "plateposition"
    t.string   "platebc"
    t.string   "batch_number"
    t.string   "tissue_type"
    t.string   "storage_medium_text"
    t.string   "country"
    t.string   "province"
    t.datetime "date_collected"
    t.string   "collected_on_day"
    t.string   "collected_on_month"
    t.string   "collected_on_year"
    t.string   "collected_by"
    t.datetime "date_received"
    t.string   "received_by"
    t.text     "receiver_comments"
    t.datetime "date_submitted"
    t.string   "submitted_by"
    t.text     "submitter_comments"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "coordinate_system"
    t.string   "locality"
    t.string   "locality_type_text"
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
    t.decimal  "true_latitude",               :precision => 18, :scale => 9
    t.decimal  "true_longitude",              :precision => 18, :scale => 9
    t.string   "sample_bc_prv"
    t.string   "shipping_material_txt_prv"
    t.string   "location_measurement_method"
    t.boolean  "approved",                                                   :default => false
  end

  add_index "samples", ["organism_id"], :name => "index_samples_on_organism_id"
  add_index "samples", ["project_id"], :name => "index_samples_on_project_id"
  add_index "samples", ["approved"], :name => "index_samples_on_approved"

  create_table "security_settings", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "level",      :default => 0
  end

  add_index "security_settings", ["project_id"], :name => "index_security_settings_on_project_id"
  add_index "security_settings", ["user_id"], :name => "index_security_settings_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shippingmaterials", :force => true do |t|
    t.string "medium_short_desc"
    t.string "medium_long_desc"
  end

  create_table "storage_media", :force => true do |t|
    t.string "storage_medium"
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
    t.boolean  "is_admin",                                :default => false
    t.boolean  "data_entry_only",                         :default => false
  end

  create_table "y_chromosome_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "haplotype"
  end

  create_table "y_chromosome_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "TR3G6"
  end

  add_index "y_chromosome_final_horizontals_1", ["organism_id"], :name => "index_y_chromosome_final_horizontals_1_on_organism_id"

  create_table "y_chromosome_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.string  "1"
    t.string  "2"
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "many grasshoppers"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "y_chromosome_final_horizontals_17", ["organism_id"], :name => "index_y_chromosome_final_horizontals_17_on_organism_id"

  create_table "y_chromosome_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_2", ["organism_id"], :name => "index_y_chromosome_final_horizontals_2_on_organism_id"

  create_table "y_chromosome_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "many grasshoppers"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "y_chromosome_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.string  "1"
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "many grasshoppers"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.string  "1"
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "many grasshoppers"
    t.string  "Y-Intron"
  end

  create_table "y_chromosome_seqs", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
  end

  create_table "y_chromosomes", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
    t.text    "comments"
    t.integer "locu_id"
    t.boolean "approved",    :default => false
  end

  add_index "y_chromosomes", ["finalResult"], :name => "index_y_chromosomes_on_finalResult"
  add_index "y_chromosomes", ["project_id"], :name => "index_y_chromosomes_on_project_id"
  add_index "y_chromosomes", ["approved"], :name => "index_y_chromosomes_on_approved"

end
