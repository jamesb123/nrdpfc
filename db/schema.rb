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

ActiveRecord::Schema.define(:version => 20131024224207) do

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

  add_index "data_queries", ["access_key"], :name => "index_data_queries_on_access_key"

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
    t.decimal "pcr_quantity",         :precision => 12, :scale => 4
    t.string  "pcr_ct"
    t.decimal "pcr_slope",            :precision => 10, :scale => 4
    t.decimal "pcr_y_intercept",      :precision => 10, :scale => 4
    t.decimal "pcr_rsquared",         :precision => 5,  :scale => 4
  end

  add_index "dna_results", ["sample_id"], :name => "dna_results_sample_id"
  add_index "dna_results", ["project_id"], :name => "index_dna_results_on_project_id"

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
  add_index "dynamic_attributes", ["scoper_type"], :name => "index_dynamic_attributes_on_scoper_type"
  add_index "dynamic_attributes", ["scoper_id"], :name => "index_dynamic_attributes_on_scoper_id"

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
    t.string  "ZFX_SRY"
    t.string  "ZFX_ZFY"
  end

  add_index "gender_final_horizontals_1", ["organism_id"], :name => "index_gender_final_horizontals_1_on_organism_id"

  create_table "gender_final_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_10", ["organism_id"], :name => "index_gender_final_horizontals_10_on_organism_id"

  create_table "gender_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_11", ["organism_id"], :name => "index_gender_final_horizontals_11_on_organism_id"

  create_table "gender_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_12", ["organism_id"], :name => "index_gender_final_horizontals_12_on_organism_id"

  create_table "gender_final_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "ZFX/ZFY"
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_13", ["organism_id"], :name => "index_gender_final_horizontals_13_on_organism_id"

  create_table "gender_final_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "ZFX/ZFY"
  end

  add_index "gender_final_horizontals_14", ["organism_id"], :name => "index_gender_final_horizontals_14_on_organism_id"

  create_table "gender_final_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_15", ["organism_id"], :name => "index_gender_final_horizontals_15_on_organism_id"

  create_table "gender_final_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_16", ["organism_id"], :name => "index_gender_final_horizontals_16_on_organism_id"

  create_table "gender_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "a"
    t.string  "l3"
    t.string  "ZFX/SRY"
  end

  create_table "gender_final_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_18", ["organism_id"], :name => "index_gender_final_horizontals_18_on_organism_id"

  create_table "gender_final_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_19", ["organism_id"], :name => "index_gender_final_horizontals_19_on_organism_id"

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

  create_table "gender_final_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_21", ["organism_id"], :name => "index_gender_final_horizontals_21_on_organism_id"

  create_table "gender_final_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_22", ["organism_id"], :name => "index_gender_final_horizontals_22_on_organism_id"

  create_table "gender_final_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Zfx/Zfy"
    t.string  "ZFX/SRY"
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_23", ["organism_id"], :name => "index_gender_final_horizontals_23_on_organism_id"

  create_table "gender_final_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_24", ["organism_id"], :name => "index_gender_final_horizontals_24_on_organism_id"

  create_table "gender_final_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_25", ["organism_id"], :name => "index_gender_final_horizontals_25_on_organism_id"

  create_table "gender_final_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_26", ["organism_id"], :name => "index_gender_final_horizontals_26_on_organism_id"

  create_table "gender_final_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_27", ["organism_id"], :name => "index_gender_final_horizontals_27_on_organism_id"

  create_table "gender_final_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_28", ["organism_id"], :name => "index_gender_final_horizontals_28_on_organism_id"

  create_table "gender_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1"
  end

  add_index "gender_final_horizontals_3", ["organism_id"], :name => "index_gender_final_horizontals_3_on_organism_id"

  create_table "gender_final_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_30", ["organism_id"], :name => "index_gender_final_horizontals_30_on_organism_id"

  create_table "gender_final_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_31", ["organism_id"], :name => "index_gender_final_horizontals_31_on_organism_id"

  create_table "gender_final_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_33", ["organism_id"], :name => "index_gender_final_horizontals_33_on_organism_id"

  create_table "gender_final_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_35", ["organism_id"], :name => "index_gender_final_horizontals_35_on_organism_id"

  create_table "gender_final_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_36", ["organism_id"], :name => "index_gender_final_horizontals_36_on_organism_id"

  create_table "gender_final_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_37", ["organism_id"], :name => "index_gender_final_horizontals_37_on_organism_id"

  create_table "gender_final_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_38", ["organism_id"], :name => "index_gender_final_horizontals_38_on_organism_id"

  create_table "gender_final_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_39", ["organism_id"], :name => "index_gender_final_horizontals_39_on_organism_id"

  create_table "gender_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_4", ["organism_id"], :name => "index_gender_final_horizontals_4_on_organism_id"

  create_table "gender_final_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_40", ["organism_id"], :name => "index_gender_final_horizontals_40_on_organism_id"

  create_table "gender_final_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_41", ["organism_id"], :name => "index_gender_final_horizontals_41_on_organism_id"

  create_table "gender_final_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_42", ["organism_id"], :name => "index_gender_final_horizontals_42_on_organism_id"

  create_table "gender_final_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "SRY and ZFX"
  end

  add_index "gender_final_horizontals_43", ["organism_id"], :name => "index_gender_final_horizontals_43_on_organism_id"

  create_table "gender_final_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "SRY and ZFX"
  end

  add_index "gender_final_horizontals_44", ["organism_id"], :name => "index_gender_final_horizontals_44_on_organism_id"

  create_table "gender_final_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_47", ["organism_id"], :name => "index_gender_final_horizontals_47_on_organism_id"

  create_table "gender_final_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_49", ["organism_id"], :name => "index_gender_final_horizontals_49_on_organism_id"

  create_table "gender_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_5", ["organism_id"], :name => "index_gender_final_horizontals_5_on_organism_id"

  create_table "gender_final_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_50", ["organism_id"], :name => "index_gender_final_horizontals_50_on_organism_id"

  create_table "gender_final_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "ZFX/SRY"
    t.string  "ZFX/ZFY"
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_51", ["organism_id"], :name => "index_gender_final_horizontals_51_on_organism_id"

  create_table "gender_final_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_57", ["organism_id"], :name => "index_gender_final_horizontals_57_on_organism_id"

  create_table "gender_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_6", ["organism_id"], :name => "index_gender_final_horizontals_6_on_organism_id"

  create_table "gender_final_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_64", ["organism_id"], :name => "index_gender_final_horizontals_64_on_organism_id"

  create_table "gender_final_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_67", ["organism_id"], :name => "index_gender_final_horizontals_67_on_organism_id"

  create_table "gender_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "temp"
    t.string  "ZFX/SRY"
    t.string  "ZFX/ZFY"
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_7", ["organism_id"], :name => "index_gender_final_horizontals_7_on_organism_id"

  create_table "gender_final_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "gender_final_horizontals_8", ["organism_id"], :name => "index_gender_final_horizontals_8_on_organism_id"

  create_table "gender_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "gender_final_horizontals_9", ["organism_id"], :name => "index_gender_final_horizontals_9_on_organism_id"

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
    t.date    "date_genotyped"
  end

  add_index "genders", ["finalResult"], :name => "index_genders_on_finalResult"
  add_index "genders", ["project_id"], :name => "index_genders_on_project_id"
  add_index "genders", ["sample_id"], :name => "index_genders_on_sample_id"

  create_table "imports", :force => true do |t|
    t.string   "datatype"
    t.integer  "processed",        :default => 0
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "locus", ["project_id"], :name => "index_locus_on_project_id"

  create_table "meta_datas", :force => true do |t|
    t.integer  "project_id"
    t.string   "m_name"
    t.string   "m_desc"
    t.string   "m_author"
    t.datetime "m_date_added"
    t.string   "m_document_name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string  "organism_code",        :limit => 128
    t.string  "EuglDRB1a"
    t.string  "EuglDRB1b"
    t.string  "EuglDRB2infnulla"
    t.string  "EuglDRB2infnullb"
    t.string  "EuglDRB2withoutnulla"
    t.string  "EuglDRB2withoutnullb"
  end

  add_index "mhc_final_horizontals_1", ["organism_id"], :name => "index_mhc_final_horizontals_1_on_organism_id"

  create_table "mhc_final_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_10", ["organism_id"], :name => "index_mhc_final_horizontals_10_on_organism_id"

  create_table "mhc_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",     :limit => 128
    t.string  "MHC_DRB_exon_2_aa"
    t.string  "MHC_DRB_exon_2_ab"
    t.string  "MHC_DRB_exon_2_ba"
    t.string  "MHC_DRB_exon_2_bb"
    t.string  "MHC_DRA_aa"
    t.string  "MHC_DRA_ab"
    t.string  "MHC_DRA_ba"
    t.string  "MHC_DRA_bb"
  end

  add_index "mhc_final_horizontals_11", ["organism_id"], :name => "index_mhc_final_horizontals_11_on_organism_id"

  create_table "mhc_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_12", ["organism_id"], :name => "index_mhc_final_horizontals_12_on_organism_id"

  create_table "mhc_final_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_13", ["organism_id"], :name => "index_mhc_final_horizontals_13_on_organism_id"

  create_table "mhc_final_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_14", ["organism_id"], :name => "index_mhc_final_horizontals_14_on_organism_id"

  create_table "mhc_final_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_15", ["organism_id"], :name => "index_mhc_final_horizontals_15_on_organism_id"

  create_table "mhc_final_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_16", ["organism_id"], :name => "index_mhc_final_horizontals_16_on_organism_id"

  create_table "mhc_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "aa"
    t.string  "ab"
    t.string  "socola"
    t.string  "socolb"
  end

  create_table "mhc_final_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_18", ["organism_id"], :name => "index_mhc_final_horizontals_18_on_organism_id"

  create_table "mhc_final_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_19", ["organism_id"], :name => "index_mhc_final_horizontals_19_on_organism_id"

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

  create_table "mhc_final_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_21", ["organism_id"], :name => "index_mhc_final_horizontals_21_on_organism_id"

  create_table "mhc_final_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_22", ["organism_id"], :name => "index_mhc_final_horizontals_22_on_organism_id"

  create_table "mhc_final_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_23", ["organism_id"], :name => "index_mhc_final_horizontals_23_on_organism_id"

  create_table "mhc_final_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_24", ["organism_id"], :name => "index_mhc_final_horizontals_24_on_organism_id"

  create_table "mhc_final_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_25", ["organism_id"], :name => "index_mhc_final_horizontals_25_on_organism_id"

  create_table "mhc_final_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_26", ["organism_id"], :name => "index_mhc_final_horizontals_26_on_organism_id"

  create_table "mhc_final_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_27", ["organism_id"], :name => "index_mhc_final_horizontals_27_on_organism_id"

  create_table "mhc_final_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_28", ["organism_id"], :name => "index_mhc_final_horizontals_28_on_organism_id"

  create_table "mhc_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_3", ["organism_id"], :name => "index_mhc_final_horizontals_3_on_organism_id"

  create_table "mhc_final_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_30", ["organism_id"], :name => "index_mhc_final_horizontals_30_on_organism_id"

  create_table "mhc_final_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_31", ["organism_id"], :name => "index_mhc_final_horizontals_31_on_organism_id"

  create_table "mhc_final_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_33", ["organism_id"], :name => "index_mhc_final_horizontals_33_on_organism_id"

  create_table "mhc_final_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_35", ["organism_id"], :name => "index_mhc_final_horizontals_35_on_organism_id"

  create_table "mhc_final_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_36", ["organism_id"], :name => "index_mhc_final_horizontals_36_on_organism_id"

  create_table "mhc_final_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_37", ["organism_id"], :name => "index_mhc_final_horizontals_37_on_organism_id"

  create_table "mhc_final_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_38", ["organism_id"], :name => "index_mhc_final_horizontals_38_on_organism_id"

  create_table "mhc_final_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_39", ["organism_id"], :name => "index_mhc_final_horizontals_39_on_organism_id"

  create_table "mhc_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_4", ["organism_id"], :name => "index_mhc_final_horizontals_4_on_organism_id"

  create_table "mhc_final_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_40", ["organism_id"], :name => "index_mhc_final_horizontals_40_on_organism_id"

  create_table "mhc_final_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_41", ["organism_id"], :name => "index_mhc_final_horizontals_41_on_organism_id"

  create_table "mhc_final_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_42", ["organism_id"], :name => "index_mhc_final_horizontals_42_on_organism_id"

  create_table "mhc_final_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_43", ["organism_id"], :name => "index_mhc_final_horizontals_43_on_organism_id"

  create_table "mhc_final_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_44", ["organism_id"], :name => "index_mhc_final_horizontals_44_on_organism_id"

  create_table "mhc_final_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_47", ["organism_id"], :name => "index_mhc_final_horizontals_47_on_organism_id"

  create_table "mhc_final_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_49", ["organism_id"], :name => "index_mhc_final_horizontals_49_on_organism_id"

  create_table "mhc_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_5", ["organism_id"], :name => "index_mhc_final_horizontals_5_on_organism_id"

  create_table "mhc_final_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_50", ["organism_id"], :name => "index_mhc_final_horizontals_50_on_organism_id"

  create_table "mhc_final_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_51", ["organism_id"], :name => "index_mhc_final_horizontals_51_on_organism_id"

  create_table "mhc_final_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_57", ["organism_id"], :name => "index_mhc_final_horizontals_57_on_organism_id"

  create_table "mhc_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_6", ["organism_id"], :name => "index_mhc_final_horizontals_6_on_organism_id"

  create_table "mhc_final_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_64", ["organism_id"], :name => "index_mhc_final_horizontals_64_on_organism_id"

  create_table "mhc_final_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_67", ["organism_id"], :name => "index_mhc_final_horizontals_67_on_organism_id"

  create_table "mhc_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_7", ["organism_id"], :name => "index_mhc_final_horizontals_7_on_organism_id"

  create_table "mhc_final_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_8", ["organism_id"], :name => "index_mhc_final_horizontals_8_on_organism_id"

  create_table "mhc_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mhc_final_horizontals_9", ["organism_id"], :name => "index_mhc_final_horizontals_9_on_organism_id"

  create_table "mhc_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
    t.integer "locu_id"
    t.integer "mt_dna_id"
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
  end

  add_index "mhcs", ["finalResult"], :name => "index_mhcs_on_finalResult"
  add_index "mhcs", ["project_id"], :name => "index_mhcs_on_project_id"
  add_index "mhcs", ["sample_id"], :name => "index_mhcs_on_sample_id"

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
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
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
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_1", ["organism_id"], :name => "index_microsatellite_final_horizontals_1_on_organism_id"

  create_table "microsatellite_final_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_10", ["organism_id"], :name => "index_microsatellite_final_horizontals_10_on_organism_id"

  create_table "microsatellite_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
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
    t.integer "ZFX/Ya"
    t.integer "ZFX/Yb"
  end

  add_index "microsatellite_final_horizontals_11", ["organism_id"], :name => "index_microsatellite_final_horizontals_11_on_organism_id"

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

  add_index "microsatellite_final_horizontals_12", ["organism_id"], :name => "index_microsatellite_final_horizontals_12_on_organism_id"

  create_table "microsatellite_final_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "EV37MNa"
    t.integer "EV37MNb"
    t.integer "EV94MNa"
    t.integer "EV94MNb"
    t.integer "FCB1a"
    t.integer "FCB1b"
    t.integer "FCB10a"
    t.integer "FCB10b"
    t.integer "FCB11a"
    t.integer "FCB11b"
    t.integer "FCB16a"
    t.integer "FCB16b"
    t.integer "FCB17a"
    t.integer "FCB17b"
    t.integer "FCB3a"
    t.integer "FCB3b"
    t.integer "FCB4a"
    t.integer "FCB4b"
    t.integer "FCB5a"
    t.integer "FCB5b"
    t.integer "FCB6a"
    t.integer "FCB6b"
    t.integer "TexVet5a"
    t.integer "TexVet5b"
    t.integer "TexVet19a"
    t.integer "TexVet19b"
    t.integer "Mk6a"
    t.integer "Mk6b"
    t.integer "Gata028a"
    t.integer "Gata028b"
    t.integer "Ev1Pma"
    t.integer "Ev1Pmb"
  end

  add_index "microsatellite_final_horizontals_13", ["organism_id"], :name => "index_microsatellite_final_horizontals_13_on_organism_id"

  create_table "microsatellite_final_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "FCB11a"
    t.integer "FCB11b"
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

  add_index "microsatellite_final_horizontals_14", ["organism_id"], :name => "index_microsatellite_final_horizontals_14_on_organism_id"

  create_table "microsatellite_final_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "VVE2-110a"
    t.integer "VVE2-110b"
    t.integer "VVE2-111a"
    t.integer "VVE2-111b"
    t.integer "VVE2-64a"
    t.integer "VVE2-64b"
    t.integer "VVE3-131a"
    t.integer "VVE3-131b"
    t.integer "VVE5-33a"
    t.integer "VVE5-33b"
    t.integer "VVE5-45a"
    t.integer "VVE5-45b"
    t.integer "VVE-M17a"
    t.integer "VVE-M17b"
    t.integer "VVE-M19a"
    t.integer "VVE-M19b"
    t.integer "VVE-M25a"
    t.integer "VVE-M25b"
  end

  add_index "microsatellite_final_horizontals_15", ["organism_id"], :name => "index_microsatellite_final_horizontals_15_on_organism_id"

  create_table "microsatellite_final_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_16", ["organism_id"], :name => "index_microsatellite_final_horizontals_16_on_organism_id"

  create_table "microsatellite_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "microsatellite_final_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "EV104a"
    t.integer "EV104b"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "FCB4a"
    t.integer "FCB4b"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "TexVet11a"
    t.integer "TexVet11b"
    t.integer "TexVet16a"
    t.integer "TexVet16b"
    t.integer "TexVet17a"
    t.integer "TexVet17b"
  end

  add_index "microsatellite_final_horizontals_18", ["organism_id"], :name => "index_microsatellite_final_horizontals_18_on_organism_id"

  create_table "microsatellite_final_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_19", ["organism_id"], :name => "index_microsatellite_final_horizontals_19_on_organism_id"

  create_table "microsatellite_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "G10Aa"
    t.integer "G10Ab"
    t.integer "G10Ba"
    t.integer "G10Bb"
    t.integer "G10Ca"
    t.integer "G10Cb"
    t.integer "G10Da"
    t.integer "G10Db"
    t.integer "G10Ha"
    t.integer "G10Hb"
    t.integer "G10Ja"
    t.integer "G10Jb"
    t.integer "G10La"
    t.integer "G10Lb"
    t.integer "G10Ma"
    t.integer "G10Mb"
    t.integer "G10Pa"
    t.integer "G10Pb"
    t.integer "G10Ua"
    t.integer "G10Ub"
    t.integer "G10Xa"
    t.integer "G10Xb"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU59a"
    t.integer "MU59b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
  end

  add_index "microsatellite_final_horizontals_2", ["organism_id"], :name => "index_microsatellite_final_horizontals_2_on_organism_id"

  create_table "microsatellite_final_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  create_table "microsatellite_final_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "CXX20a"
    t.integer "CXX20b"
    t.integer "G10Aa"
    t.integer "G10Ab"
    t.integer "G10Ba"
    t.integer "G10Bb"
    t.integer "G10Ca"
    t.integer "G10Cb"
    t.integer "G10Da"
    t.integer "G10Db"
    t.integer "G10Ha"
    t.integer "G10Hb"
    t.integer "G10Ja"
    t.integer "G10Jb"
    t.integer "G10La"
    t.integer "G10Lb"
    t.integer "G10Ma"
    t.integer "G10Mb"
    t.integer "G10Oa"
    t.integer "G10Ob"
    t.integer "G10Pa"
    t.integer "G10Pb"
    t.integer "G10Ua"
    t.integer "G10Ub"
    t.integer "G10Xa"
    t.integer "G10Xb"
    t.integer "MSUT1a"
    t.integer "MSUT1b"
    t.integer "MSUT2a"
    t.integer "MSUT2b"
    t.integer "MSUT3a"
    t.integer "MSUT3b"
    t.integer "MSUT4a"
    t.integer "MSUT4b"
    t.integer "MSUT5a"
    t.integer "MSUT5b"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MSUT8a"
    t.integer "MSUT8b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU09a"
    t.integer "MU09b"
    t.integer "MU10a"
    t.integer "MU10b"
    t.integer "MU15a"
    t.integer "MU15b"
    t.integer "MU23a"
    t.integer "MU23b"
    t.integer "MU26a"
    t.integer "MU26b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU51a"
    t.integer "MU51b"
    t.integer "MU59a"
    t.integer "MU59b"
    t.integer "MU61a"
    t.integer "MU61b"
  end

  add_index "microsatellite_final_horizontals_21", ["organism_id"], :name => "index_microsatellite_final_horizontals_21_on_organism_id"

  create_table "microsatellite_final_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_22", ["organism_id"], :name => "index_microsatellite_final_horizontals_22_on_organism_id"

  create_table "microsatellite_final_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
  end

  add_index "microsatellite_final_horizontals_23", ["organism_id"], :name => "index_microsatellite_final_horizontals_23_on_organism_id"

  create_table "microsatellite_final_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_24", ["organism_id"], :name => "index_microsatellite_final_horizontals_24_on_organism_id"

  create_table "microsatellite_final_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_25", ["organism_id"], :name => "index_microsatellite_final_horizontals_25_on_organism_id"

  create_table "microsatellite_final_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_26", ["organism_id"], :name => "index_microsatellite_final_horizontals_26_on_organism_id"

  create_table "microsatellite_final_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_27", ["organism_id"], :name => "index_microsatellite_final_horizontals_27_on_organism_id"

  create_table "microsatellite_final_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "PeEr07a"
    t.integer "PeEr07b"
    t.integer "PeER02a"
    t.integer "PeER02b"
    t.integer "PeEr04a"
    t.integer "PeEr04b"
    t.integer "PeEr09a"
    t.integer "PeEr09b"
    t.integer "PeEr03a"
    t.integer "PeEr03b"
    t.integer "PeEr06a"
    t.integer "PeEr06b"
    t.integer "Pel149a"
    t.integer "Pel149b"
    t.integer "Pel086a"
    t.integer "Pel086b"
    t.integer "Pel304a"
    t.integer "Pel304b"
  end

  add_index "microsatellite_final_horizontals_28", ["organism_id"], :name => "index_microsatellite_final_horizontals_28_on_organism_id"

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

  add_index "microsatellite_final_horizontals_3", ["organism_id"], :name => "index_microsatellite_final_horizontals_3_on_organism_id"

  create_table "microsatellite_final_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Hg42a"
    t.integer "Hg42b"
    t.integer "Hg61a"
    t.integer "Hg61b"
    t.integer "Hg63a"
    t.integer "Hg63b"
    t.integer "Hg810a"
    t.integer "Hg810b"
    t.integer "Hg89a"
    t.integer "Hg89b"
    t.integer "Hi15a"
    t.integer "Hi15b"
    t.integer "Hi16a"
    t.integer "Hi16b"
    t.integer "Hi2a"
    t.integer "Hi2b"
    t.integer "Hi8a"
    t.integer "Hi8b"
    t.integer "Lc28a"
    t.integer "Lc28b"
    t.integer "Lc6a"
    t.integer "Lc6b"
    t.integer "SGPv10a"
    t.integer "SGPv10b"
    t.integer "SGPv11a"
    t.integer "SGPv11b"
    t.integer "SGPv9a"
    t.integer "SGPv9b"
  end

  add_index "microsatellite_final_horizontals_30", ["organism_id"], :name => "index_microsatellite_final_horizontals_30_on_organism_id"

  create_table "microsatellite_final_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "BL42a"
    t.integer "BL42b"
    t.integer "BM848a"
    t.integer "BM848b"
    t.integer "BMS1788a"
    t.integer "BMS1788b"
    t.integer "Map2Ca"
    t.integer "Map2Cb"
    t.integer "RT24a"
    t.integer "RT24b"
    t.integer "RT30a"
    t.integer "RT30b"
    t.integer "RT5a"
    t.integer "RT5b"
    t.integer "RT6a"
    t.integer "RT6b"
    t.integer "RT9a"
    t.integer "RT9b"
  end

  add_index "microsatellite_final_horizontals_31", ["organism_id"], :name => "index_microsatellite_final_horizontals_31_on_organism_id"

  create_table "microsatellite_final_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_33", ["organism_id"], :name => "index_microsatellite_final_horizontals_33_on_organism_id"

  create_table "microsatellite_final_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Sfo12a"
    t.integer "Sfo12b"
    t.integer "Sfo18a"
    t.integer "Sfo18b"
    t.integer "Sfo23a"
    t.integer "Sfo23b"
    t.integer "SfoB52a"
    t.integer "SfoB52b"
    t.integer "SfoC113a"
    t.integer "SfoC113b"
    t.integer "SfoC115a"
    t.integer "SfoC115b"
    t.integer "SfoC129a"
    t.integer "SfoC129b"
    t.integer "SfoC24a"
    t.integer "SfoC24b"
    t.integer "SfoC28a"
    t.integer "SfoC28b"
    t.integer "SfoC38a"
    t.integer "SfoC38b"
    t.integer "SfoC86a"
    t.integer "SfoC86b"
    t.integer "SfoC88a"
    t.integer "SfoC88b"
    t.integer "SfoD100a"
    t.integer "SfoD100b"
    t.integer "SfoD75a"
    t.integer "SfoD75b"
  end

  add_index "microsatellite_final_horizontals_35", ["organism_id"], :name => "index_microsatellite_final_horizontals_35_on_organism_id"

  create_table "microsatellite_final_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_36", ["organism_id"], :name => "index_microsatellite_final_horizontals_36_on_organism_id"

  create_table "microsatellite_final_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "SL06a"
    t.integer "SL06b"
    t.integer "SL21a"
    t.integer "SL21b"
    t.integer "SL31a"
    t.integer "SL31b"
    t.integer "SL65a"
    t.integer "SL65b"
  end

  add_index "microsatellite_final_horizontals_37", ["organism_id"], :name => "index_microsatellite_final_horizontals_37_on_organism_id"

  create_table "microsatellite_final_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  add_index "microsatellite_final_horizontals_38", ["organism_id"], :name => "index_microsatellite_final_horizontals_38_on_organism_id"

  create_table "microsatellite_final_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_39", ["organism_id"], :name => "index_microsatellite_final_horizontals_39_on_organism_id"

  create_table "microsatellite_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_4", ["organism_id"], :name => "index_microsatellite_final_horizontals_4_on_organism_id"

  create_table "microsatellite_final_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Ssa_197a"
    t.integer "Ssa_197b"
    t.integer "Ssa_202a"
    t.integer "Ssa_202b"
    t.integer "SSa_85a"
    t.integer "SSa_85b"
    t.integer "SSsp_1605a"
    t.integer "SSsp_1605b"
    t.integer "SSsp_2201a"
    t.integer "SSsp_2201b"
    t.integer "SSsp_2213a"
    t.integer "SSsp_2213b"
    t.integer "SSsp_2215a"
    t.integer "SSsp_2215b"
    t.integer "SSsp_2216a"
    t.integer "SSsp_2216b"
    t.integer "SSsp_G7a"
    t.integer "SSsp_G7b"
  end

  add_index "microsatellite_final_horizontals_40", ["organism_id"], :name => "index_microsatellite_final_horizontals_40_on_organism_id"

  create_table "microsatellite_final_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_41", ["organism_id"], :name => "index_microsatellite_final_horizontals_41_on_organism_id"

  create_table "microsatellite_final_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_42", ["organism_id"], :name => "index_microsatellite_final_horizontals_42_on_organism_id"

  create_table "microsatellite_final_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "BA1a"
    t.integer "BA1b"
    t.integer "BA2a"
    t.integer "BA2b"
    t.integer "BA3a"
    t.integer "BA3b"
    t.integer "BA4a"
    t.integer "BA4b"
    t.integer "CS19a"
    t.integer "CS19b"
    t.integer "Gg10a"
    t.integer "Gg10b"
    t.integer "Gg14a"
    t.integer "Gg14b"
    t.integer "Gg192a"
    t.integer "Gg192b"
    t.integer "Gg25a"
    t.integer "Gg25b"
    t.integer "Gg3a"
    t.integer "Gg3b"
    t.integer "Gg37a"
    t.integer "Gg37b"
    t.integer "Gg4a"
    t.integer "Gg4b"
    t.integer "Gg42a"
    t.integer "Gg42b"
    t.integer "Gg452a"
    t.integer "Gg452b"
    t.integer "Gg465a"
    t.integer "Gg465b"
    t.integer "Gg471a"
    t.integer "Gg471b"
    t.integer "Gg7a"
    t.integer "Gg7b"
    t.integer "Gg9a"
    t.integer "Gg9b"
    t.integer "Ggu101a"
    t.integer "Ggu101b"
    t.integer "Ggu216a"
    t.integer "Ggu216b"
    t.integer "Ggu234a"
    t.integer "Ggu234b"
    t.integer "Ggu443a"
    t.integer "Ggu443b"
    t.integer "Ggu454a"
    t.integer "Ggu454b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
    t.integer "LS8a"
    t.integer "LS8b"
    t.integer "Lut604a"
    t.integer "Lut604b"
    t.integer "Ma1a"
    t.integer "Ma1b"
    t.integer "Ma10a"
    t.integer "Ma10b"
    t.integer "Ma15a"
    t.integer "Ma15b"
    t.integer "Ma19a"
    t.integer "Ma19b"
    t.integer "Ma3a"
    t.integer "Ma3b"
    t.integer "Ma4a"
    t.integer "Ma4b"
    t.integer "Ma9a"
    t.integer "Ma9b"
    t.integer "Mer041a"
    t.integer "Mer041b"
    t.integer "Mer82a"
    t.integer "Mer82b"
    t.integer "Mvi87a"
    t.integer "Mvi87b"
    t.integer "Mvis002a"
    t.integer "Mvis002b"
    t.integer "Mvis020a"
    t.integer "Mvis020b"
    t.integer "Mvis027a"
    t.integer "Mvis027b"
    t.integer "Mvis095a"
    t.integer "Mvis095b"
    t.integer "Mvis72a"
    t.integer "Mvis72b"
    t.integer "Mvis75a"
    t.integer "Mvis75b"
    t.integer "PV9a"
    t.integer "PV9b"
  end

  add_index "microsatellite_final_horizontals_43", ["organism_id"], :name => "index_microsatellite_final_horizontals_43_on_organism_id"

  create_table "microsatellite_final_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "BA1a"
    t.integer "BA1b"
    t.integer "BA2a"
    t.integer "BA2b"
    t.integer "BA3a"
    t.integer "BA3b"
    t.integer "BA4a"
    t.integer "BA4b"
    t.integer "CS19a"
    t.integer "CS19b"
    t.integer "Gg10a"
    t.integer "Gg10b"
    t.integer "Gg14a"
    t.integer "Gg14b"
    t.integer "Gg192a"
    t.integer "Gg192b"
    t.integer "Gg25a"
    t.integer "Gg25b"
    t.integer "Gg3a"
    t.integer "Gg3b"
    t.integer "Gg37a"
    t.integer "Gg37b"
    t.integer "Gg4a"
    t.integer "Gg4b"
    t.integer "Gg42a"
    t.integer "Gg42b"
    t.integer "Gg452a"
    t.integer "Gg452b"
    t.integer "Gg465a"
    t.integer "Gg465b"
    t.integer "Gg471a"
    t.integer "Gg471b"
    t.integer "Gg7a"
    t.integer "Gg7b"
    t.integer "Gg9a"
    t.integer "Gg9b"
    t.integer "Ggu101a"
    t.integer "Ggu101b"
    t.integer "Ggu216a"
    t.integer "Ggu216b"
    t.integer "Ggu234a"
    t.integer "Ggu234b"
    t.integer "Ggu443a"
    t.integer "Ggu443b"
    t.integer "Ggu454a"
    t.integer "Ggu454b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
    t.integer "LS8a"
    t.integer "LS8b"
    t.integer "Lut604a"
    t.integer "Lut604b"
    t.integer "Ma1a"
    t.integer "Ma1b"
    t.integer "Ma10a"
    t.integer "Ma10b"
    t.integer "Ma15a"
    t.integer "Ma15b"
    t.integer "Ma19a"
    t.integer "Ma19b"
    t.integer "Ma3a"
    t.integer "Ma3b"
    t.integer "Ma4a"
    t.integer "Ma4b"
    t.integer "Ma9a"
    t.integer "Ma9b"
    t.integer "Mer041a"
    t.integer "Mer041b"
    t.integer "Mer82a"
    t.integer "Mer82b"
    t.integer "Mvi87a"
    t.integer "Mvi87b"
    t.integer "Mvis002a"
    t.integer "Mvis002b"
    t.integer "Mvis020a"
    t.integer "Mvis020b"
    t.integer "Mvis027a"
    t.integer "Mvis027b"
    t.integer "Mvis095a"
    t.integer "Mvis095b"
    t.integer "Mvis72a"
    t.integer "Mvis72b"
    t.integer "Mvis75a"
    t.integer "Mvis75b"
    t.integer "PV9a"
    t.integer "PV9b"
  end

  add_index "microsatellite_final_horizontals_44", ["organism_id"], :name => "index_microsatellite_final_horizontals_44_on_organism_id"

  create_table "microsatellite_final_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_47", ["organism_id"], :name => "index_microsatellite_final_horizontals_47_on_organism_id"

  create_table "microsatellite_final_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_49", ["organism_id"], :name => "index_microsatellite_final_horizontals_49_on_organism_id"

  create_table "microsatellite_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_5", ["organism_id"], :name => "index_microsatellite_final_horizontals_5_on_organism_id"

  create_table "microsatellite_final_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "SO386a"
    t.integer "SO386b"
    t.integer "SW24a"
    t.integer "SW24b"
    t.integer "S0155a"
    t.integer "S0155b"
    t.integer "S0005a"
    t.integer "S0005b"
    t.integer "SW240a"
    t.integer "SW240b"
    t.integer "SW857a"
    t.integer "SW857b"
    t.integer "S0101a"
    t.integer "S0101b"
    t.integer "S00090a"
    t.integer "S00090b"
  end

  add_index "microsatellite_final_horizontals_50", ["organism_id"], :name => "index_microsatellite_final_horizontals_50_on_organism_id"

  create_table "microsatellite_final_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
  end

  add_index "microsatellite_final_horizontals_51", ["organism_id"], :name => "index_microsatellite_final_horizontals_51_on_organism_id"

  create_table "microsatellite_final_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_57", ["organism_id"], :name => "index_microsatellite_final_horizontals_57_on_organism_id"

  create_table "microsatellite_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_6", ["organism_id"], :name => "index_microsatellite_final_horizontals_6_on_organism_id"

  create_table "microsatellite_final_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_64", ["organism_id"], :name => "index_microsatellite_final_horizontals_64_on_organism_id"

  create_table "microsatellite_final_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_67", ["organism_id"], :name => "index_microsatellite_final_horizontals_67_on_organism_id"

  create_table "microsatellite_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
    t.integer "2010a"
    t.integer "2010b"
    t.integer "383a"
    t.integer "383b"
    t.integer "2202a"
    t.integer "2202b"
    t.integer "CPH11a"
    t.integer "CPH11b"
  end

  add_index "microsatellite_final_horizontals_7", ["organism_id"], :name => "index_microsatellite_final_horizontals_7_on_organism_id"

  create_table "microsatellite_final_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "microsatellite_final_horizontals_8", ["organism_id"], :name => "index_microsatellite_final_horizontals_8_on_organism_id"

  create_table "microsatellite_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "109a"
    t.integer "109b"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_final_horizontals_9", ["organism_id"], :name => "index_microsatellite_final_horizontals_9_on_organism_id"

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
    t.integer "TV14a"
    t.integer "TV14b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV19a"
    t.integer "TV19b"
    t.integer "TV20a"
    t.integer "TV20b"
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
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_1", ["sample_id"], :name => "index_microsatellite_horizontals_1_on_sample_id"

  create_table "microsatellite_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_10", ["sample_id"], :name => "index_microsatellite_horizontals_10_on_sample_id"

  create_table "microsatellite_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
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
    t.integer "ZFX/Ya"
    t.integer "ZFX/Yb"
  end

  add_index "microsatellite_horizontals_11", ["sample_id"], :name => "index_microsatellite_horizontals_11_on_sample_id"

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

  add_index "microsatellite_horizontals_12", ["sample_id"], :name => "index_microsatellite_horizontals_12_on_sample_id"

  create_table "microsatellite_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "EV37MNa"
    t.integer "EV37MNb"
    t.integer "EV94MNa"
    t.integer "EV94MNb"
    t.integer "FCB1a"
    t.integer "FCB1b"
    t.integer "FCB10a"
    t.integer "FCB10b"
    t.integer "FCB11a"
    t.integer "FCB11b"
    t.integer "FCB16a"
    t.integer "FCB16b"
    t.integer "FCB17a"
    t.integer "FCB17b"
    t.integer "FCB3a"
    t.integer "FCB3b"
    t.integer "FCB4a"
    t.integer "FCB4b"
    t.integer "FCB5a"
    t.integer "FCB5b"
    t.integer "FCB6a"
    t.integer "FCB6b"
    t.integer "TexVet5a"
    t.integer "TexVet5b"
    t.integer "TexVet19a"
    t.integer "TexVet19b"
    t.integer "Mk6a"
    t.integer "Mk6b"
    t.integer "Gata028a"
    t.integer "Gata028b"
    t.integer "Ev1Pma"
    t.integer "Ev1Pmb"
  end

  add_index "microsatellite_horizontals_13", ["sample_id"], :name => "index_microsatellite_horizontals_13_on_sample_id"

  create_table "microsatellite_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "FCB11a"
    t.integer "FCB11b"
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

  add_index "microsatellite_horizontals_14", ["sample_id"], :name => "index_microsatellite_horizontals_14_on_sample_id"

  create_table "microsatellite_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "VVE2-110a"
    t.integer "VVE2-110b"
    t.integer "VVE2-111a"
    t.integer "VVE2-111b"
    t.integer "VVE2-64a"
    t.integer "VVE2-64b"
    t.integer "VVE3-131a"
    t.integer "VVE3-131b"
    t.integer "VVE5-33a"
    t.integer "VVE5-33b"
    t.integer "VVE5-45a"
    t.integer "VVE5-45b"
    t.integer "VVE-M17a"
    t.integer "VVE-M17b"
    t.integer "VVE-M19a"
    t.integer "VVE-M19b"
    t.integer "VVE-M25a"
    t.integer "VVE-M25b"
  end

  add_index "microsatellite_horizontals_15", ["sample_id"], :name => "index_microsatellite_horizontals_15_on_sample_id"

  create_table "microsatellite_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_16", ["sample_id"], :name => "index_microsatellite_horizontals_16_on_sample_id"

  create_table "microsatellite_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  create_table "microsatellite_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "EV104a"
    t.integer "EV104b"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "FCB4a"
    t.integer "FCB4b"
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "RW34a"
    t.integer "RW34b"
    t.integer "RW48a"
    t.integer "RW48b"
    t.integer "TexVet11a"
    t.integer "TexVet11b"
    t.integer "TexVet16a"
    t.integer "TexVet16b"
    t.integer "TexVet17a"
    t.integer "TexVet17b"
  end

  add_index "microsatellite_horizontals_18", ["sample_id"], :name => "index_microsatellite_horizontals_18_on_sample_id"

  create_table "microsatellite_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_19", ["sample_id"], :name => "index_microsatellite_horizontals_19_on_sample_id"

  create_table "microsatellite_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "G10Aa"
    t.integer "G10Ab"
    t.integer "G10Ba"
    t.integer "G10Bb"
    t.integer "G10Ca"
    t.integer "G10Cb"
    t.integer "G10Da"
    t.integer "G10Db"
    t.integer "G10Ha"
    t.integer "G10Hb"
    t.integer "G10Ja"
    t.integer "G10Jb"
    t.integer "G10La"
    t.integer "G10Lb"
    t.integer "G10Ma"
    t.integer "G10Mb"
    t.integer "G10Pa"
    t.integer "G10Pb"
    t.integer "G10Ua"
    t.integer "G10Ub"
    t.integer "G10Xa"
    t.integer "G10Xb"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU59a"
    t.integer "MU59b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
  end

  add_index "microsatellite_horizontals_2", ["sample_id"], :name => "index_microsatellite_horizontals_2_on_sample_id"

  create_table "microsatellite_horizontals_20", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  create_table "microsatellite_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "CXX20a"
    t.integer "CXX20b"
    t.integer "G10Aa"
    t.integer "G10Ab"
    t.integer "G10Ba"
    t.integer "G10Bb"
    t.integer "G10Ca"
    t.integer "G10Cb"
    t.integer "G10Da"
    t.integer "G10Db"
    t.integer "G10Ha"
    t.integer "G10Hb"
    t.integer "G10Ja"
    t.integer "G10Jb"
    t.integer "G10La"
    t.integer "G10Lb"
    t.integer "G10Ma"
    t.integer "G10Mb"
    t.integer "G10Oa"
    t.integer "G10Ob"
    t.integer "G10Pa"
    t.integer "G10Pb"
    t.integer "G10Ua"
    t.integer "G10Ub"
    t.integer "G10Xa"
    t.integer "G10Xb"
    t.integer "MSUT1a"
    t.integer "MSUT1b"
    t.integer "MSUT2a"
    t.integer "MSUT2b"
    t.integer "MSUT3a"
    t.integer "MSUT3b"
    t.integer "MSUT4a"
    t.integer "MSUT4b"
    t.integer "MSUT5a"
    t.integer "MSUT5b"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MSUT8a"
    t.integer "MSUT8b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU09a"
    t.integer "MU09b"
    t.integer "MU10a"
    t.integer "MU10b"
    t.integer "MU15a"
    t.integer "MU15b"
    t.integer "MU23a"
    t.integer "MU23b"
    t.integer "MU26a"
    t.integer "MU26b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU51a"
    t.integer "MU51b"
    t.integer "MU59a"
    t.integer "MU59b"
    t.integer "MU61a"
    t.integer "MU61b"
  end

  add_index "microsatellite_horizontals_21", ["sample_id"], :name => "index_microsatellite_horizontals_21_on_sample_id"

  create_table "microsatellite_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_22", ["sample_id"], :name => "index_microsatellite_horizontals_22_on_sample_id"

  create_table "microsatellite_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
  end

  add_index "microsatellite_horizontals_23", ["sample_id"], :name => "index_microsatellite_horizontals_23_on_sample_id"

  create_table "microsatellite_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_24", ["sample_id"], :name => "index_microsatellite_horizontals_24_on_sample_id"

  create_table "microsatellite_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_25", ["sample_id"], :name => "index_microsatellite_horizontals_25_on_sample_id"

  create_table "microsatellite_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_26", ["sample_id"], :name => "index_microsatellite_horizontals_26_on_sample_id"

  create_table "microsatellite_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_27", ["sample_id"], :name => "index_microsatellite_horizontals_27_on_sample_id"

  create_table "microsatellite_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "PeEr07a"
    t.integer "PeEr07b"
    t.integer "PeER02a"
    t.integer "PeER02b"
    t.integer "PeEr04a"
    t.integer "PeEr04b"
    t.integer "PeEr09a"
    t.integer "PeEr09b"
    t.integer "PeEr03a"
    t.integer "PeEr03b"
    t.integer "PeEr06a"
    t.integer "PeEr06b"
    t.integer "Pel149a"
    t.integer "Pel149b"
    t.integer "Pel086a"
    t.integer "Pel086b"
    t.integer "Pel304a"
    t.integer "Pel304b"
  end

  add_index "microsatellite_horizontals_28", ["sample_id"], :name => "index_microsatellite_horizontals_28_on_sample_id"

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

  add_index "microsatellite_horizontals_3", ["sample_id"], :name => "index_microsatellite_horizontals_3_on_sample_id"

  create_table "microsatellite_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Hg42a"
    t.integer "Hg42b"
    t.integer "Hg61a"
    t.integer "Hg61b"
    t.integer "Hg63a"
    t.integer "Hg63b"
    t.integer "Hg810a"
    t.integer "Hg810b"
    t.integer "Hg89a"
    t.integer "Hg89b"
    t.integer "Hi15a"
    t.integer "Hi15b"
    t.integer "Hi16a"
    t.integer "Hi16b"
    t.integer "Hi2a"
    t.integer "Hi2b"
    t.integer "Hi8a"
    t.integer "Hi8b"
    t.integer "Lc28a"
    t.integer "Lc28b"
    t.integer "Lc6a"
    t.integer "Lc6b"
    t.integer "SGPv10a"
    t.integer "SGPv10b"
    t.integer "SGPv11a"
    t.integer "SGPv11b"
    t.integer "SGPv9a"
    t.integer "SGPv9b"
  end

  add_index "microsatellite_horizontals_30", ["sample_id"], :name => "index_microsatellite_horizontals_30_on_sample_id"

  create_table "microsatellite_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "BL42a"
    t.integer "BL42b"
    t.integer "BM848a"
    t.integer "BM848b"
    t.integer "BMS1788a"
    t.integer "BMS1788b"
    t.integer "Map2Ca"
    t.integer "Map2Cb"
    t.integer "RT24a"
    t.integer "RT24b"
    t.integer "RT30a"
    t.integer "RT30b"
    t.integer "RT5a"
    t.integer "RT5b"
    t.integer "RT6a"
    t.integer "RT6b"
    t.integer "RT9a"
    t.integer "RT9b"
  end

  add_index "microsatellite_horizontals_31", ["sample_id"], :name => "index_microsatellite_horizontals_31_on_sample_id"

  create_table "microsatellite_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_33", ["sample_id"], :name => "index_microsatellite_horizontals_33_on_sample_id"

  create_table "microsatellite_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Sfo12a"
    t.integer "Sfo12b"
    t.integer "Sfo18a"
    t.integer "Sfo18b"
    t.integer "Sfo23a"
    t.integer "Sfo23b"
    t.integer "SfoB52a"
    t.integer "SfoB52b"
    t.integer "SfoC113a"
    t.integer "SfoC113b"
    t.integer "SfoC115a"
    t.integer "SfoC115b"
    t.integer "SfoC129a"
    t.integer "SfoC129b"
    t.integer "SfoC24a"
    t.integer "SfoC24b"
    t.integer "SfoC28a"
    t.integer "SfoC28b"
    t.integer "SfoC38a"
    t.integer "SfoC38b"
    t.integer "SfoC86a"
    t.integer "SfoC86b"
    t.integer "SfoC88a"
    t.integer "SfoC88b"
    t.integer "SfoD100a"
    t.integer "SfoD100b"
    t.integer "SfoD75a"
    t.integer "SfoD75b"
  end

  add_index "microsatellite_horizontals_35", ["sample_id"], :name => "index_microsatellite_horizontals_35_on_sample_id"

  create_table "microsatellite_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_36", ["sample_id"], :name => "index_microsatellite_horizontals_36_on_sample_id"

  create_table "microsatellite_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "SL06a"
    t.integer "SL06b"
    t.integer "SL21a"
    t.integer "SL21b"
    t.integer "SL31a"
    t.integer "SL31b"
    t.integer "SL65a"
    t.integer "SL65b"
  end

  add_index "microsatellite_horizontals_37", ["sample_id"], :name => "index_microsatellite_horizontals_37_on_sample_id"

  create_table "microsatellite_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "RW417a"
    t.integer "RW417b"
    t.integer "TV17a"
    t.integer "TV17b"
    t.integer "TV20a"
    t.integer "TV20b"
  end

  add_index "microsatellite_horizontals_38", ["sample_id"], :name => "index_microsatellite_horizontals_38_on_sample_id"

  create_table "microsatellite_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_39", ["sample_id"], :name => "index_microsatellite_horizontals_39_on_sample_id"

  create_table "microsatellite_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_4", ["sample_id"], :name => "index_microsatellite_horizontals_4_on_sample_id"

  create_table "microsatellite_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Ssa_197a"
    t.integer "Ssa_197b"
    t.integer "Ssa_202a"
    t.integer "Ssa_202b"
    t.integer "SSa_85a"
    t.integer "SSa_85b"
    t.integer "SSsp_1605a"
    t.integer "SSsp_1605b"
    t.integer "SSsp_2201a"
    t.integer "SSsp_2201b"
    t.integer "SSsp_2213a"
    t.integer "SSsp_2213b"
    t.integer "SSsp_2215a"
    t.integer "SSsp_2215b"
    t.integer "SSsp_2216a"
    t.integer "SSsp_2216b"
    t.integer "SSsp_G7a"
    t.integer "SSsp_G7b"
  end

  add_index "microsatellite_horizontals_40", ["sample_id"], :name => "index_microsatellite_horizontals_40_on_sample_id"

  create_table "microsatellite_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_41", ["sample_id"], :name => "index_microsatellite_horizontals_41_on_sample_id"

  create_table "microsatellite_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_42", ["sample_id"], :name => "index_microsatellite_horizontals_42_on_sample_id"

  create_table "microsatellite_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "BA1a"
    t.integer "BA1b"
    t.integer "BA2a"
    t.integer "BA2b"
    t.integer "BA3a"
    t.integer "BA3b"
    t.integer "BA4a"
    t.integer "BA4b"
    t.integer "CS19a"
    t.integer "CS19b"
    t.integer "Gg10a"
    t.integer "Gg10b"
    t.integer "Gg14a"
    t.integer "Gg14b"
    t.integer "Gg192a"
    t.integer "Gg192b"
    t.integer "Gg25a"
    t.integer "Gg25b"
    t.integer "Gg3a"
    t.integer "Gg3b"
    t.integer "Gg37a"
    t.integer "Gg37b"
    t.integer "Gg4a"
    t.integer "Gg4b"
    t.integer "Gg42a"
    t.integer "Gg42b"
    t.integer "Gg452a"
    t.integer "Gg452b"
    t.integer "Gg465a"
    t.integer "Gg465b"
    t.integer "Gg471a"
    t.integer "Gg471b"
    t.integer "Gg7a"
    t.integer "Gg7b"
    t.integer "Gg9a"
    t.integer "Gg9b"
    t.integer "Ggu101a"
    t.integer "Ggu101b"
    t.integer "Ggu216a"
    t.integer "Ggu216b"
    t.integer "Ggu234a"
    t.integer "Ggu234b"
    t.integer "Ggu443a"
    t.integer "Ggu443b"
    t.integer "Ggu454a"
    t.integer "Ggu454b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
    t.integer "LS8a"
    t.integer "LS8b"
    t.integer "Lut604a"
    t.integer "Lut604b"
    t.integer "Ma1a"
    t.integer "Ma1b"
    t.integer "Ma10a"
    t.integer "Ma10b"
    t.integer "Ma15a"
    t.integer "Ma15b"
    t.integer "Ma19a"
    t.integer "Ma19b"
    t.integer "Ma3a"
    t.integer "Ma3b"
    t.integer "Ma4a"
    t.integer "Ma4b"
    t.integer "Ma9a"
    t.integer "Ma9b"
    t.integer "Mer041a"
    t.integer "Mer041b"
    t.integer "Mer82a"
    t.integer "Mer82b"
    t.integer "Mvi87a"
    t.integer "Mvi87b"
    t.integer "Mvis002a"
    t.integer "Mvis002b"
    t.integer "Mvis020a"
    t.integer "Mvis020b"
    t.integer "Mvis027a"
    t.integer "Mvis027b"
    t.integer "Mvis095a"
    t.integer "Mvis095b"
    t.integer "Mvis72a"
    t.integer "Mvis72b"
    t.integer "Mvis75a"
    t.integer "Mvis75b"
    t.integer "PV9a"
    t.integer "PV9b"
  end

  add_index "microsatellite_horizontals_43", ["sample_id"], :name => "index_microsatellite_horizontals_43_on_sample_id"

  create_table "microsatellite_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "BA1a"
    t.integer "BA1b"
    t.integer "BA2a"
    t.integer "BA2b"
    t.integer "BA3a"
    t.integer "BA3b"
    t.integer "BA4a"
    t.integer "BA4b"
    t.integer "CS19a"
    t.integer "CS19b"
    t.integer "Gg10a"
    t.integer "Gg10b"
    t.integer "Gg14a"
    t.integer "Gg14b"
    t.integer "Gg192a"
    t.integer "Gg192b"
    t.integer "Gg25a"
    t.integer "Gg25b"
    t.integer "Gg3a"
    t.integer "Gg3b"
    t.integer "Gg37a"
    t.integer "Gg37b"
    t.integer "Gg4a"
    t.integer "Gg4b"
    t.integer "Gg42a"
    t.integer "Gg42b"
    t.integer "Gg452a"
    t.integer "Gg452b"
    t.integer "Gg465a"
    t.integer "Gg465b"
    t.integer "Gg471a"
    t.integer "Gg471b"
    t.integer "Gg7a"
    t.integer "Gg7b"
    t.integer "Gg9a"
    t.integer "Gg9b"
    t.integer "Ggu101a"
    t.integer "Ggu101b"
    t.integer "Ggu216a"
    t.integer "Ggu216b"
    t.integer "Ggu234a"
    t.integer "Ggu234b"
    t.integer "Ggu443a"
    t.integer "Ggu443b"
    t.integer "Ggu454a"
    t.integer "Ggu454b"
    t.integer "HG36a"
    t.integer "HG36b"
    t.integer "LS16a"
    t.integer "LS16b"
    t.integer "LS8a"
    t.integer "LS8b"
    t.integer "Lut604a"
    t.integer "Lut604b"
    t.integer "Ma1a"
    t.integer "Ma1b"
    t.integer "Ma10a"
    t.integer "Ma10b"
    t.integer "Ma15a"
    t.integer "Ma15b"
    t.integer "Ma19a"
    t.integer "Ma19b"
    t.integer "Ma3a"
    t.integer "Ma3b"
    t.integer "Ma4a"
    t.integer "Ma4b"
    t.integer "Ma9a"
    t.integer "Ma9b"
    t.integer "Mer041a"
    t.integer "Mer041b"
    t.integer "Mer82a"
    t.integer "Mer82b"
    t.integer "Mvi87a"
    t.integer "Mvi87b"
    t.integer "Mvis002a"
    t.integer "Mvis002b"
    t.integer "Mvis020a"
    t.integer "Mvis020b"
    t.integer "Mvis027a"
    t.integer "Mvis027b"
    t.integer "Mvis095a"
    t.integer "Mvis095b"
    t.integer "Mvis72a"
    t.integer "Mvis72b"
    t.integer "Mvis75a"
    t.integer "Mvis75b"
    t.integer "PV9a"
    t.integer "PV9b"
  end

  add_index "microsatellite_horizontals_44", ["sample_id"], :name => "index_microsatellite_horizontals_44_on_sample_id"

  create_table "microsatellite_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_47", ["sample_id"], :name => "index_microsatellite_horizontals_47_on_sample_id"

  create_table "microsatellite_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_49", ["sample_id"], :name => "index_microsatellite_horizontals_49_on_sample_id"

  create_table "microsatellite_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_5", ["sample_id"], :name => "index_microsatellite_horizontals_5_on_sample_id"

  create_table "microsatellite_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "SO386a"
    t.integer "SO386b"
    t.integer "SW24a"
    t.integer "SW24b"
    t.integer "S0155a"
    t.integer "S0155b"
    t.integer "S0005a"
    t.integer "S0005b"
    t.integer "SW240a"
    t.integer "SW240b"
    t.integer "SW857a"
    t.integer "SW857b"
    t.integer "S0101a"
    t.integer "S0101b"
    t.integer "S00090a"
    t.integer "S00090b"
  end

  add_index "microsatellite_horizontals_50", ["sample_id"], :name => "index_microsatellite_horizontals_50_on_sample_id"

  create_table "microsatellite_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
  end

  add_index "microsatellite_horizontals_51", ["sample_id"], :name => "index_microsatellite_horizontals_51_on_sample_id"

  create_table "microsatellite_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_57", ["sample_id"], :name => "index_microsatellite_horizontals_57_on_sample_id"

  create_table "microsatellite_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_6", ["sample_id"], :name => "index_microsatellite_horizontals_6_on_sample_id"

  create_table "microsatellite_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_64", ["sample_id"], :name => "index_microsatellite_horizontals_64_on_sample_id"

  create_table "microsatellite_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_67", ["sample_id"], :name => "index_microsatellite_horizontals_67_on_sample_id"

  create_table "microsatellite_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "109a"
    t.integer "109b"
    t.integer "123a"
    t.integer "123b"
    t.integer "147a"
    t.integer "147b"
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
    t.integer "253a"
    t.integer "253b"
    t.integer "377a"
    t.integer "377b"
    t.integer "410a"
    t.integer "410b"
    t.integer "442a"
    t.integer "442b"
    t.integer "2010a"
    t.integer "2010b"
    t.integer "383a"
    t.integer "383b"
    t.integer "2202a"
    t.integer "2202b"
    t.integer "CPH11a"
    t.integer "CPH11b"
  end

  add_index "microsatellite_horizontals_7", ["sample_id"], :name => "index_microsatellite_horizontals_7_on_sample_id"

  create_table "microsatellite_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
  end

  add_index "microsatellite_horizontals_8", ["sample_id"], :name => "index_microsatellite_horizontals_8_on_sample_id"

  create_table "microsatellite_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "109a"
    t.integer "109b"
    t.integer "Unknowna"
    t.integer "Unknownb"
  end

  add_index "microsatellite_horizontals_9", ["sample_id"], :name => "index_microsatellite_horizontals_9_on_sample_id"

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
    t.integer "allele_1_peak_height", :limit => 6,  :precision => 6, :scale => 0
    t.integer "allele_2_peak_height", :limit => 6,  :precision => 6, :scale => 0
    t.integer "locu_id"
    t.decimal "allele_1_size",                      :precision => 6, :scale => 2
    t.decimal "allele_2_size",                      :precision => 6, :scale => 2
    t.date    "date_genotyped"
  end

  add_index "microsatellites", ["sample_id", "project_id", "locus"], :name => "Index_2"
  add_index "microsatellites", ["locus"], :name => "index_microsatellites_on_locus"
  add_index "microsatellites", ["allele1"], :name => "index_microsatellites_on_allele1"
  add_index "microsatellites", ["allele2"], :name => "index_microsatellites_on_allele2"
  add_index "microsatellites", ["finalResult"], :name => "index_microsatellites_on_finalResult"
  add_index "microsatellites", ["gel"], :name => "index_microsatellites_on_gel"
  add_index "microsatellites", ["well"], :name => "index_microsatellites_on_well"
  add_index "microsatellites", ["locu_id"], :name => "index_microsatellites_on_locu_id"

  create_table "microsatellites_project_001_by_sample", :force => true do |t|
    t.string  "project_id",        :limit => 50
    t.float   "organism_code"
    t.float   "org_Sample"
    t.float   "extraction_number"
    t.float   "EV1Pma"
    t.float   "EVPm1b"
    t.float   "EV37Mna"
    t.float   "EV37Mnb"
    t.float   "GATA028a"
    t.float   "GATA028b"
    t.float   "GT023a"
    t.float   "GT023b"
    t.float   "GT271a"
    t.float   "GT271b"
    t.float   "IGFa"
    t.float   "IGFb"
    t.float   "RW18a"
    t.float   "RW18b"
    t.float   "RW25a"
    t.float   "RW25b"
    t.float   "RW31a"
    t.float   "RW31b"
    t.float   "RW34a"
    t.float   "RW34b"
    t.float   "RW45a"
    t.float   "RW45b"
    t.float   "RW48a"
    t.float   "RW48b"
    t.float   "RW212a"
    t.float   "RW212b"
    t.float   "RW217a"
    t.float   "RW217b"
    t.float   "RW219a"
    t.float   "RW219b"
    t.float   "RW417a"
    t.float   "RW417b"
    t.float   "SAM25a"
    t.float   "SAM25b"
    t.float   "TR2F3a"
    t.float   "TR2F3b"
    t.float   "TR2G5a"
    t.float   "TR2G5b"
    t.float   "TR3A1a"
    t.float   "TR3A1b"
    t.float   "TR3F2a"
    t.float   "TR3F2b"
    t.float   "TR3F7a"
    t.float   "TR3F7b"
    t.float   "TR3G1a"
    t.float   "TR3G1b"
    t.float   "TR3G2a"
    t.float   "TR3G2b"
    t.float   "TR3G5a"
    t.float   "TR3G5b"
    t.float   "TR3G6a"
    t.float   "TR3G6b"
    t.float   "TR3G10a"
    t.float   "TR3G10b"
    t.float   "TR3G11a"
    t.float   "TR3G11b"
    t.float   "TR3G13a"
    t.float   "TR3G13b"
    t.float   "TR3H4a"
    t.float   "TR3H4b"
    t.float   "TR3H14a"
    t.float   "TR3H14b"
    t.float   "TV14a"
    t.float   "TV14b"
    t.float   "TV17a"
    t.float   "TV17b"
    t.float   "TV19a"
    t.float   "TV19b"
    t.float   "TV20a"
    t.float   "TV20b"
    t.integer "sample_id"
  end

  add_index "microsatellites_project_001_by_sample", ["project_id"], :name => "project_id"

  create_table "mt_dna_final_horizontals", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code"
    t.integer "haplotype"
  end

  create_table "mt_dna_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "Cytochrome b"
  end

  add_index "mt_dna_final_horizontals_1", ["organism_id"], :name => "index_mt_dna_final_horizontals_1_on_organism_id"

  create_table "mt_dna_final_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_10", ["organism_id"], :name => "index_mt_dna_final_horizontals_10_on_organism_id"

  create_table "mt_dna_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control region"
  end

  add_index "mt_dna_final_horizontals_11", ["organism_id"], :name => "index_mt_dna_final_horizontals_11_on_organism_id"

  create_table "mt_dna_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "Control Region, Yoshida et al. (2001)"
  end

  add_index "mt_dna_final_horizontals_12", ["organism_id"], :name => "index_mt_dna_final_horizontals_12_on_organism_id"

  create_table "mt_dna_final_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_13", ["organism_id"], :name => "index_mt_dna_final_horizontals_13_on_organism_id"

  create_table "mt_dna_final_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "Control region, Yoshida et al. (2001)"
  end

  add_index "mt_dna_final_horizontals_14", ["organism_id"], :name => "index_mt_dna_final_horizontals_14_on_organism_id"

  create_table "mt_dna_final_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
    t.string  "Cytochrome B"
  end

  add_index "mt_dna_final_horizontals_15", ["organism_id"], :name => "index_mt_dna_final_horizontals_15_on_organism_id"

  create_table "mt_dna_final_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_16", ["organism_id"], :name => "index_mt_dna_final_horizontals_16_on_organism_id"

  create_table "mt_dna_final_horizontals_17", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",                         :limit => 128
    t.string  "Control Region"
    t.string  "Control region, Yoshida et al. (2001)"
    t.string  "cytochrome b"
    t.string  "mtDNA"
  end

  create_table "mt_dna_final_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "cytochrome b"
  end

  add_index "mt_dna_final_horizontals_18", ["organism_id"], :name => "index_mt_dna_final_horizontals_18_on_organism_id"

  create_table "mt_dna_final_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_19", ["organism_id"], :name => "index_mt_dna_final_horizontals_19_on_organism_id"

  create_table "mt_dna_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
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

  create_table "mt_dna_final_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_21", ["organism_id"], :name => "index_mt_dna_final_horizontals_21_on_organism_id"

  create_table "mt_dna_final_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_22", ["organism_id"], :name => "index_mt_dna_final_horizontals_22_on_organism_id"

  create_table "mt_dna_final_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_23", ["organism_id"], :name => "index_mt_dna_final_horizontals_23_on_organism_id"

  create_table "mt_dna_final_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_24", ["organism_id"], :name => "index_mt_dna_final_horizontals_24_on_organism_id"

  create_table "mt_dna_final_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_25", ["organism_id"], :name => "index_mt_dna_final_horizontals_25_on_organism_id"

  create_table "mt_dna_final_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_26", ["organism_id"], :name => "index_mt_dna_final_horizontals_26_on_organism_id"

  create_table "mt_dna_final_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_27", ["organism_id"], :name => "index_mt_dna_final_horizontals_27_on_organism_id"

  create_table "mt_dna_final_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_28", ["organism_id"], :name => "index_mt_dna_final_horizontals_28_on_organism_id"

  create_table "mt_dna_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "cytochrome b"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_3", ["organism_id"], :name => "index_mt_dna_final_horizontals_3_on_organism_id"

  create_table "mt_dna_final_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_30", ["organism_id"], :name => "index_mt_dna_final_horizontals_30_on_organism_id"

  create_table "mt_dna_final_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "214"
    t.string  "427"
  end

  add_index "mt_dna_final_horizontals_31", ["organism_id"], :name => "index_mt_dna_final_horizontals_31_on_organism_id"

  create_table "mt_dna_final_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_33", ["organism_id"], :name => "index_mt_dna_final_horizontals_33_on_organism_id"

  create_table "mt_dna_final_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_35", ["organism_id"], :name => "index_mt_dna_final_horizontals_35_on_organism_id"

  create_table "mt_dna_final_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_36", ["organism_id"], :name => "index_mt_dna_final_horizontals_36_on_organism_id"

  create_table "mt_dna_final_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_37", ["organism_id"], :name => "index_mt_dna_final_horizontals_37_on_organism_id"

  create_table "mt_dna_final_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_38", ["organism_id"], :name => "index_mt_dna_final_horizontals_38_on_organism_id"

  create_table "mt_dna_final_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_39", ["organism_id"], :name => "index_mt_dna_final_horizontals_39_on_organism_id"

  create_table "mt_dna_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "cytochrome b"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_4", ["organism_id"], :name => "index_mt_dna_final_horizontals_4_on_organism_id"

  create_table "mt_dna_final_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_40", ["organism_id"], :name => "index_mt_dna_final_horizontals_40_on_organism_id"

  create_table "mt_dna_final_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_41", ["organism_id"], :name => "index_mt_dna_final_horizontals_41_on_organism_id"

  create_table "mt_dna_final_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_42", ["organism_id"], :name => "index_mt_dna_final_horizontals_42_on_organism_id"

  create_table "mt_dna_final_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
  end

  add_index "mt_dna_final_horizontals_43", ["organism_id"], :name => "index_mt_dna_final_horizontals_43_on_organism_id"

  create_table "mt_dna_final_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
  end

  add_index "mt_dna_final_horizontals_44", ["organism_id"], :name => "index_mt_dna_final_horizontals_44_on_organism_id"

  create_table "mt_dna_final_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_47", ["organism_id"], :name => "index_mt_dna_final_horizontals_47_on_organism_id"

  create_table "mt_dna_final_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_49", ["organism_id"], :name => "index_mt_dna_final_horizontals_49_on_organism_id"

  create_table "mt_dna_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_5", ["organism_id"], :name => "index_mt_dna_final_horizontals_5_on_organism_id"

  create_table "mt_dna_final_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_50", ["organism_id"], :name => "index_mt_dna_final_horizontals_50_on_organism_id"

  create_table "mt_dna_final_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_51", ["organism_id"], :name => "index_mt_dna_final_horizontals_51_on_organism_id"

  create_table "mt_dna_final_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_57", ["organism_id"], :name => "index_mt_dna_final_horizontals_57_on_organism_id"

  create_table "mt_dna_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_6", ["organism_id"], :name => "index_mt_dna_final_horizontals_6_on_organism_id"

  create_table "mt_dna_final_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_64", ["organism_id"], :name => "index_mt_dna_final_horizontals_64_on_organism_id"

  create_table "mt_dna_final_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_67", ["organism_id"], :name => "index_mt_dna_final_horizontals_67_on_organism_id"

  create_table "mt_dna_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "control region"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_7", ["organism_id"], :name => "index_mt_dna_final_horizontals_7_on_organism_id"

  create_table "mt_dna_final_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "mt_dna_final_horizontals_8", ["organism_id"], :name => "index_mt_dna_final_horizontals_8_on_organism_id"

  create_table "mt_dna_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "AdminLocus1"
    t.string  "Unknown"
  end

  add_index "mt_dna_final_horizontals_9", ["organism_id"], :name => "index_mt_dna_final_horizontals_9_on_organism_id"

  create_table "mt_dna_seqs", :force => true do |t|
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
    t.text    "comments"
    t.integer "locu_id"
    t.integer "mt_dna_id"
  end

  add_index "mt_dna_seqs", ["project_id"], :name => "index_mt_dna_seqs_on_project_id"

  create_table "mt_dnas", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "haplotype",       :limit => 12
    t.string  "gelNum"
    t.string  "wellNum"
    t.boolean "finalResult"
    t.text    "comments"
    t.integer "locu_id"
    t.date    "date_sequenced"
    t.string  "haplotype_short"
    t.string  "haplotype_long"
  end

  add_index "mt_dnas", ["finalResult"], :name => "index_mt_dnas_on_finalResult"
  add_index "mt_dnas", ["project_id"], :name => "index_mt_dnas_on_project_id"
  add_index "mt_dnas", ["sample_id"], :name => "index_mt_dnas_on_sample_id"

  create_table "nats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisms", :force => true do |t|
    t.integer "project_id"
    t.string  "organism_code"
    t.string  "comment"
  end

  add_index "organisms", ["project_id", "id"], :name => "index_organisms_on_project_id_and_id"
  add_index "organisms", ["project_id"], :name => "index_organisms_on_project_id"

  create_table "organizations", :force => true do |t|
    t.string   "org_name"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string  "organism_label"
    t.string  "photo_id_label"
    t.string  "field_ident_label"
    t.string  "opt_col_1"
    t.string  "opt_col_2"
    t.string  "opt_col_3"
    t.string  "opt_col_4"
    t.string  "opt_col_5"
    t.string  "opt_col_6"
    t.string  "opt_col_7"
    t.string  "opt_col_8"
    t.string  "opt_col_9"
    t.string  "opt_col_10"
    t.string  "opt_col_11"
    t.string  "opt_col_12"
    t.string  "opt_col_13"
    t.string  "opt_col_14"
    t.string  "opt_col_15"
    t.string  "opt_col_16"
    t.string  "opt_col_17"
    t.string  "opt_col_18"
    t.string  "opt_col_19"
    t.string  "opt_col_20"
    t.string  "opt_col_21"
    t.string  "opt_col_22"
    t.string  "opt_col_23"
    t.string  "opt_col_24"
    t.string  "opt_col_25"
  end

  add_index "projects", ["description"], :name => "index_projects_on_description"

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
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_index"
    t.string  "sample_bc"
    t.string  "platebc"
    t.string  "plateposition"
    t.string  "field_code"
    t.string  "batch_number"
    t.string  "original_tissue_type"
    t.string  "storage_medium_text"
    t.string  "country"
    t.string  "province"
    t.date    "date_collected"
    t.string  "collected_on_day"
    t.string  "collected_on_month"
    t.string  "collected_on_year"
    t.string  "collected_by"
    t.date    "date_received"
    t.string  "received_by"
    t.text    "receiver_comments"
    t.date    "date_submitted"
    t.string  "submitted_by"
    t.text    "submitter_comments"
    t.string  "latitude"
    t.string  "longitude"
    t.string  "coordinate_system"
    t.string  "locality"
    t.string  "locality_type_text"
    t.string  "locality_comments"
    t.string  "location_accuracy"
    t.string  "storage_building"
    t.string  "storage_room"
    t.string  "storage_fridge"
    t.string  "storage_box"
    t.string  "xy_position"
    t.boolean "tissue_remaining"
    t.string  "type_lat_long"
    t.integer "locality_type_id"
    t.integer "shippingmaterial_id"
    t.integer "tissue_type_id"
    t.integer "province_id"
    t.integer "storage_medium_id"
    t.integer "country_id"
    t.integer "extraction_method_id"
    t.decimal "true_latitude",               :precision => 18, :scale => 9
    t.decimal "true_longitude",              :precision => 18, :scale => 9
    t.string  "sample_bc_prv"
    t.string  "shipping_material_txt_prv"
    t.string  "location_measurement_method"
    t.boolean "approved",                                                   :default => false
    t.integer "sighting_id"
    t.integer "survey_id"
    t.string  "location_1"
    t.string  "location_2"
    t.string  "location_3"
    t.string  "location_4"
    t.text    "collector_comments"
    t.string  "text_tissue_type"
    t.string  "organization_text"
    t.string  "user_id"
    t.string  "field_ident"
    t.string  "current_location"
    t.text    "comments"
    t.string  "import_permit"
    t.string  "export_permit"
    t.date    "shipping_date"
    t.boolean "received_by_trent"
    t.boolean "dna_extracted"
    t.boolean "profiling_completed"
    t.date    "extraction_date"
    t.date    "profiling_date"
    t.string  "photo_id"
    t.boolean "remote_data_entry"
    t.string  "discrepancy"
    t.text    "discrepancy_comments"
    t.integer "organization_id"
    t.string  "age"
    t.string  "condition"
    t.string  "rehydrated"
    t.string  "diet_analysis"
    t.string  "profiling_done_by"
    t.string  "profiling_funded_by"
    t.string  "profile_published"
    t.string  "publication_name"
    t.string  "sample_image1"
    t.string  "chicken_company"
    t.string  "chicken_feathering"
    t.string  "chicken_declared_gender"
    t.string  "chicken_meat_part"
    t.string  "chicken_ml_duplicate"
    t.string  "chicken_country"
  end

  add_index "samples", ["organism_id"], :name => "index_samples_on_organism_id"
  add_index "samples", ["project_id"], :name => "index_samples_on_project_id"
  add_index "samples", ["approved"], :name => "index_samples_on_approved"

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "security_settings", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "level",      :default => 0
  end

  add_index "security_settings", ["project_id"], :name => "index_security_settings_on_project_id"
  add_index "security_settings", ["user_id"], :name => "index_security_settings_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
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

  create_table "sightings", :force => true do |t|
    t.integer  "project_id"
    t.integer  "survey_id"
    t.date     "sighting_date"
    t.time     "sighting_time"
    t.string   "survey_vessel"
    t.boolean  "clear"
    t.boolean  "hazy"
    t.boolean  "clouds"
    t.boolean  "overcast"
    t.boolean  "glare"
    t.boolean  "sunny"
    t.boolean  "foggy"
    t.boolean  "mainly_cloudy"
    t.boolean  "rain"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "sighting_by"
    t.string   "speed_min"
    t.string   "speed_max"
    t.string   "bearing"
    t.string   "sea_state"
    t.float    "depth"
    t.string   "sst"
    t.string   "salinity"
    t.string   "angle"
    t.string   "dist"
    t.float    "group_max"
    t.float    "group_min"
    t.float    "group_best"
    t.string   "mother_calf_pairs"
    t.string   "dist_min"
    t.string   "dolphin_speed"
    t.string   "group_comments"
    t.boolean  "logging"
    t.boolean  "slow_swim"
    t.boolean  "fast_swim"
    t.boolean  "porpoising"
    t.boolean  "chasing"
    t.boolean  "breaching"
    t.boolean  "surfing"
    t.boolean  "fluke_up"
    t.boolean  "back_arch"
    t.boolean  "bow_ride"
    t.boolean  "stern_ride"
    t.boolean  "synch"
    t.boolean  "mostly_synch"
    t.boolean  "asynch"
    t.boolean  "unidir"
    t.boolean  "mostly_unidir"
    t.boolean  "multidir"
    t.boolean  "loose_group"
    t.boolean  "adult_pairs"
    t.boolean  "subgroups"
    t.boolean  "tight_group"
    t.string   "structure_comments"
    t.boolean  "resting"
    t.boolean  "travelling"
    t.boolean  "feeding"
    t.boolean  "play"
    t.boolean  "mating_sexual"
    t.boolean  "aggression"
    t.boolean  "prey_mouth"
    t.boolean  "prey_water"
    t.boolean  "prey_fleeing"
    t.boolean  "prey_sonar"
    t.boolean  "driftnet"
    t.boolean  "sink_gillnets"
    t.boolean  "trawl"
    t.boolean  "pole_fishing"
    t.boolean  "commercial"
    t.string   "vessel_comments"
    t.boolean  "assoc_fish"
    t.boolean  "assoc_seabirds"
    t.boolean  "assoc_upwell"
    t.boolean  "assoc_weed"
    t.boolean  "assoc_debris"
    t.string   "association_comments"
    t.string   "sonar"
    t.string   "scy_cam"
    t.string   "photo_comments"
    t.string   "general_comments"
    t.integer  "id_number"
    t.string   "id_text"
    t.string   "id_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",             :default => true
    t.float    "distance"
    t.integer  "sample_id"
  end

  add_index "sightings", ["id_number"], :name => "ID_number"
  add_index "sightings", ["id_comments"], :name => "ID_comments"
  add_index "sightings", ["id_text"], :name => "ID_text"

  create_table "ssamples", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_media", :force => true do |t|
    t.string "storage_medium"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "project_id"
    t.integer  "sighting_id"
    t.date     "survey_date"
    t.time     "survey_time"
    t.integer  "interval"
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
    t.string   "boat_number"
    t.string   "net"
    t.string   "net_number"
    t.string   "obj_dir"
    t.float    "obj_dist"
    t.string   "comments"
    t.string   "weather"
    t.string   "observer_1"
    t.string   "observer_2"
    t.string   "observer_3"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",    :default => true
    t.float    "distance"
    t.integer  "sample_id"
  end

  create_table "tissue_types", :force => true do |t|
    t.string "tissue_desc"
    t.string "comment"
  end

  create_table "type_lat_long_update", :force => true do |t|
    t.string "type_lat_long"
    t.string "location_measurement_method"
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
    t.string   "name"
    t.string   "country"
    t.string   "state"
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
  end

  add_index "y_chromosome_final_horizontals_1", ["organism_id"], :name => "index_y_chromosome_final_horizontals_1_on_organism_id"

  create_table "y_chromosome_final_horizontals_10", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_10", ["organism_id"], :name => "index_y_chromosome_final_horizontals_10_on_organism_id"

  create_table "y_chromosome_final_horizontals_11", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_11", ["organism_id"], :name => "index_y_chromosome_final_horizontals_11_on_organism_id"

  create_table "y_chromosome_final_horizontals_12", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_12", ["organism_id"], :name => "index_y_chromosome_final_horizontals_12_on_organism_id"

  create_table "y_chromosome_final_horizontals_13", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_13", ["organism_id"], :name => "index_y_chromosome_final_horizontals_13_on_organism_id"

  create_table "y_chromosome_final_horizontals_14", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_14", ["organism_id"], :name => "index_y_chromosome_final_horizontals_14_on_organism_id"

  create_table "y_chromosome_final_horizontals_15", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_15", ["organism_id"], :name => "index_y_chromosome_final_horizontals_15_on_organism_id"

  create_table "y_chromosome_final_horizontals_16", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_16", ["organism_id"], :name => "index_y_chromosome_final_horizontals_16_on_organism_id"

  create_table "y_chromosome_final_horizontals_17", :force => true do |t|
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

  create_table "y_chromosome_final_horizontals_18", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_18", ["organism_id"], :name => "index_y_chromosome_final_horizontals_18_on_organism_id"

  create_table "y_chromosome_final_horizontals_19", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_19", ["organism_id"], :name => "index_y_chromosome_final_horizontals_19_on_organism_id"

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

  create_table "y_chromosome_final_horizontals_21", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_21", ["organism_id"], :name => "index_y_chromosome_final_horizontals_21_on_organism_id"

  create_table "y_chromosome_final_horizontals_22", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_22", ["organism_id"], :name => "index_y_chromosome_final_horizontals_22_on_organism_id"

  create_table "y_chromosome_final_horizontals_23", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
  end

  add_index "y_chromosome_final_horizontals_23", ["organism_id"], :name => "index_y_chromosome_final_horizontals_23_on_organism_id"

  create_table "y_chromosome_final_horizontals_24", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_24", ["organism_id"], :name => "index_y_chromosome_final_horizontals_24_on_organism_id"

  create_table "y_chromosome_final_horizontals_25", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_25", ["organism_id"], :name => "index_y_chromosome_final_horizontals_25_on_organism_id"

  create_table "y_chromosome_final_horizontals_26", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_26", ["organism_id"], :name => "index_y_chromosome_final_horizontals_26_on_organism_id"

  create_table "y_chromosome_final_horizontals_27", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_27", ["organism_id"], :name => "index_y_chromosome_final_horizontals_27_on_organism_id"

  create_table "y_chromosome_final_horizontals_28", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_28", ["organism_id"], :name => "index_y_chromosome_final_horizontals_28_on_organism_id"

  create_table "y_chromosome_final_horizontals_3", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_3", ["organism_id"], :name => "index_y_chromosome_final_horizontals_3_on_organism_id"

  create_table "y_chromosome_final_horizontals_30", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_30", ["organism_id"], :name => "index_y_chromosome_final_horizontals_30_on_organism_id"

  create_table "y_chromosome_final_horizontals_31", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_31", ["organism_id"], :name => "index_y_chromosome_final_horizontals_31_on_organism_id"

  create_table "y_chromosome_final_horizontals_33", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_33", ["organism_id"], :name => "index_y_chromosome_final_horizontals_33_on_organism_id"

  create_table "y_chromosome_final_horizontals_35", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_35", ["organism_id"], :name => "index_y_chromosome_final_horizontals_35_on_organism_id"

  create_table "y_chromosome_final_horizontals_36", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_36", ["organism_id"], :name => "index_y_chromosome_final_horizontals_36_on_organism_id"

  create_table "y_chromosome_final_horizontals_37", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_37", ["organism_id"], :name => "index_y_chromosome_final_horizontals_37_on_organism_id"

  create_table "y_chromosome_final_horizontals_38", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_38", ["organism_id"], :name => "index_y_chromosome_final_horizontals_38_on_organism_id"

  create_table "y_chromosome_final_horizontals_39", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_39", ["organism_id"], :name => "index_y_chromosome_final_horizontals_39_on_organism_id"

  create_table "y_chromosome_final_horizontals_4", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_4", ["organism_id"], :name => "index_y_chromosome_final_horizontals_4_on_organism_id"

  create_table "y_chromosome_final_horizontals_40", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_40", ["organism_id"], :name => "index_y_chromosome_final_horizontals_40_on_organism_id"

  create_table "y_chromosome_final_horizontals_41", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_41", ["organism_id"], :name => "index_y_chromosome_final_horizontals_41_on_organism_id"

  create_table "y_chromosome_final_horizontals_42", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_42", ["organism_id"], :name => "index_y_chromosome_final_horizontals_42_on_organism_id"

  create_table "y_chromosome_final_horizontals_43", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_43", ["organism_id"], :name => "index_y_chromosome_final_horizontals_43_on_organism_id"

  create_table "y_chromosome_final_horizontals_44", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_44", ["organism_id"], :name => "index_y_chromosome_final_horizontals_44_on_organism_id"

  create_table "y_chromosome_final_horizontals_47", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "1"
  end

  add_index "y_chromosome_final_horizontals_47", ["organism_id"], :name => "index_y_chromosome_final_horizontals_47_on_organism_id"

  create_table "y_chromosome_final_horizontals_49", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_49", ["organism_id"], :name => "index_y_chromosome_final_horizontals_49_on_organism_id"

  create_table "y_chromosome_final_horizontals_5", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_5", ["organism_id"], :name => "index_y_chromosome_final_horizontals_5_on_organism_id"

  create_table "y_chromosome_final_horizontals_50", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_50", ["organism_id"], :name => "index_y_chromosome_final_horizontals_50_on_organism_id"

  create_table "y_chromosome_final_horizontals_51", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
  end

  add_index "y_chromosome_final_horizontals_51", ["organism_id"], :name => "index_y_chromosome_final_horizontals_51_on_organism_id"

  create_table "y_chromosome_final_horizontals_57", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_57", ["organism_id"], :name => "index_y_chromosome_final_horizontals_57_on_organism_id"

  create_table "y_chromosome_final_horizontals_6", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_6", ["organism_id"], :name => "index_y_chromosome_final_horizontals_6_on_organism_id"

  create_table "y_chromosome_final_horizontals_64", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_64", ["organism_id"], :name => "index_y_chromosome_final_horizontals_64_on_organism_id"

  create_table "y_chromosome_final_horizontals_67", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_67", ["organism_id"], :name => "index_y_chromosome_final_horizontals_67_on_organism_id"

  create_table "y_chromosome_final_horizontals_7", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "34a"
    t.string  "34b"
    t.string  "41a"
    t.string  "41b"
    t.string  "Y-Intron"
    t.string  "Y_Haplotype"
    t.string  "Unknown"
  end

  add_index "y_chromosome_final_horizontals_7", ["organism_id"], :name => "index_y_chromosome_final_horizontals_7_on_organism_id"

  create_table "y_chromosome_final_horizontals_8", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
  end

  add_index "y_chromosome_final_horizontals_8", ["organism_id"], :name => "index_y_chromosome_final_horizontals_8_on_organism_id"

  create_table "y_chromosome_final_horizontals_9", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",    :limit => 128
    t.string  "testDefaultLocus"
  end

  add_index "y_chromosome_final_horizontals_9", ["organism_id"], :name => "index_y_chromosome_final_horizontals_9_on_organism_id"

  create_table "y_chromosome_seqs", :force => true do |t|
    t.integer "sample_id"
    t.integer "project_id"
    t.string  "locus"
    t.string  "allele"
    t.text    "sequence"
    t.string  "accession",  :limit => 30
    t.integer "locu_id"
    t.integer "mt_dna_id"
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
  end

  add_index "y_chromosomes", ["finalResult"], :name => "index_y_chromosomes_on_finalResult"
  add_index "y_chromosomes", ["project_id"], :name => "index_y_chromosomes_on_project_id"
  add_index "y_chromosomes", ["sample_id"], :name => "index_y_chromosomes_on_sample_id"

end
