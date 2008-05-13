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

ActiveRecord::Schema.define(:version => 46) do

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
  end

  create_table "gender_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
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
  end

  create_table "mhc_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
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
    t.string  "organism_code"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_final_horizontals_1", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.string  "EV1Pma",        :limit => 7
    t.string  "EV1Pmb",        :limit => 7
    t.string  "EV37Mna",       :limit => 7
    t.string  "EV37Mnb",       :limit => 7
    t.string  "G10Aa",         :limit => 7
    t.string  "G10Ab",         :limit => 7
    t.string  "G10Ba",         :limit => 7
    t.string  "G10Bb",         :limit => 7
    t.string  "G10Ca",         :limit => 7
    t.string  "G10Cb",         :limit => 7
    t.string  "G10Da",         :limit => 7
    t.string  "G10Db",         :limit => 7
    t.string  "G10Ha",         :limit => 7
    t.string  "G10Hb",         :limit => 7
    t.string  "G10Ja",         :limit => 7
    t.string  "G10Jb",         :limit => 7
    t.string  "G10La",         :limit => 7
    t.string  "G10Lb",         :limit => 7
    t.string  "G10Ma",         :limit => 7
    t.string  "G10Mb",         :limit => 7
    t.string  "G10Pa",         :limit => 7
    t.string  "G10Pb",         :limit => 7
    t.string  "G10Ua",         :limit => 7
    t.string  "G10Ub",         :limit => 7
    t.string  "G10Xa",         :limit => 7
    t.string  "G10Xb",         :limit => 7
    t.string  "GATA028a",      :limit => 7
    t.string  "GATA028b",      :limit => 7
    t.string  "GT023a",        :limit => 7
    t.string  "GT023b",        :limit => 7
    t.string  "GT271a",        :limit => 7
    t.string  "GT271b",        :limit => 7
    t.string  "IGFa",          :limit => 7
    t.string  "IGFb",          :limit => 7
    t.string  "MSUT10a",       :limit => 7
    t.string  "MSUT10b",       :limit => 7
    t.string  "MSUT100a",      :limit => 7
    t.string  "MSUT100b",      :limit => 7
    t.string  "MSUT101a",      :limit => 7
    t.string  "MSUT101b",      :limit => 7
    t.string  "MSUT102a",      :limit => 7
    t.string  "MSUT102b",      :limit => 7
    t.string  "MSUT103a",      :limit => 7
    t.string  "MSUT103b",      :limit => 7
    t.string  "MSUT104a",      :limit => 7
    t.string  "MSUT104b",      :limit => 7
    t.string  "MSUT105a",      :limit => 7
    t.string  "MSUT105b",      :limit => 7
    t.string  "MSUT106a",      :limit => 7
    t.string  "MSUT106b",      :limit => 7
    t.string  "MSUT107a",      :limit => 7
    t.string  "MSUT107b",      :limit => 7
    t.string  "MSUT108a",      :limit => 7
    t.string  "MSUT108b",      :limit => 7
    t.string  "MSUT109a",      :limit => 7
    t.string  "MSUT109b",      :limit => 7
    t.string  "MSUT11a",       :limit => 7
    t.string  "MSUT11b",       :limit => 7
    t.string  "MSUT110a",      :limit => 7
    t.string  "MSUT110b",      :limit => 7
    t.string  "MSUT111a",      :limit => 7
    t.string  "MSUT111b",      :limit => 7
    t.string  "MSUT112a",      :limit => 7
    t.string  "MSUT112b",      :limit => 7
    t.string  "MSUT113a",      :limit => 7
    t.string  "MSUT113b",      :limit => 7
    t.string  "MSUT114a",      :limit => 7
    t.string  "MSUT114b",      :limit => 7
    t.string  "MSUT115a",      :limit => 7
    t.string  "MSUT115b",      :limit => 7
    t.string  "MSUT116a",      :limit => 7
    t.string  "MSUT116b",      :limit => 7
    t.string  "MSUT117a",      :limit => 7
    t.string  "MSUT117b",      :limit => 7
    t.string  "MSUT118a",      :limit => 7
    t.string  "MSUT118b",      :limit => 7
    t.string  "MSUT119a",      :limit => 7
    t.string  "MSUT119b",      :limit => 7
    t.string  "MSUT12a",       :limit => 7
    t.string  "MSUT12b",       :limit => 7
    t.string  "MSUT120a",      :limit => 7
    t.string  "MSUT120b",      :limit => 7
    t.string  "MSUT121a",      :limit => 7
    t.string  "MSUT121b",      :limit => 7
    t.string  "MSUT122a",      :limit => 7
    t.string  "MSUT122b",      :limit => 7
    t.string  "MSUT123a",      :limit => 7
    t.string  "MSUT123b",      :limit => 7
    t.string  "MSUT124a",      :limit => 7
    t.string  "MSUT124b",      :limit => 7
    t.string  "MSUT125a",      :limit => 7
    t.string  "MSUT125b",      :limit => 7
    t.string  "MSUT126a",      :limit => 7
    t.string  "MSUT126b",      :limit => 7
    t.string  "MSUT127a",      :limit => 7
    t.string  "MSUT127b",      :limit => 7
    t.string  "MSUT128a",      :limit => 7
    t.string  "MSUT128b",      :limit => 7
    t.string  "MSUT129a",      :limit => 7
    t.string  "MSUT129b",      :limit => 7
    t.string  "MSUT13a",       :limit => 7
    t.string  "MSUT13b",       :limit => 7
    t.string  "MSUT130a",      :limit => 7
    t.string  "MSUT130b",      :limit => 7
    t.string  "MSUT131a",      :limit => 7
    t.string  "MSUT131b",      :limit => 7
    t.string  "MSUT132a",      :limit => 7
    t.string  "MSUT132b",      :limit => 7
    t.string  "MSUT133a",      :limit => 7
    t.string  "MSUT133b",      :limit => 7
    t.string  "MSUT134a",      :limit => 7
    t.string  "MSUT134b",      :limit => 7
    t.string  "MSUT135a",      :limit => 7
    t.string  "MSUT135b",      :limit => 7
    t.string  "MSUT136a",      :limit => 7
    t.string  "MSUT136b",      :limit => 7
    t.string  "MSUT137a",      :limit => 7
    t.string  "MSUT137b",      :limit => 7
    t.string  "MSUT138a",      :limit => 7
    t.string  "MSUT138b",      :limit => 7
    t.string  "MSUT139a",      :limit => 7
    t.string  "MSUT139b",      :limit => 7
    t.string  "MSUT14a",       :limit => 7
    t.string  "MSUT14b",       :limit => 7
    t.string  "MSUT140a",      :limit => 7
    t.string  "MSUT140b",      :limit => 7
    t.string  "MSUT141a",      :limit => 7
    t.string  "MSUT141b",      :limit => 7
    t.string  "MSUT142a",      :limit => 7
    t.string  "MSUT142b",      :limit => 7
    t.string  "MSUT143a",      :limit => 7
    t.string  "MSUT143b",      :limit => 7
    t.string  "MSUT144a",      :limit => 7
    t.string  "MSUT144b",      :limit => 7
    t.string  "MSUT145a",      :limit => 7
    t.string  "MSUT145b",      :limit => 7
    t.string  "MSUT146a",      :limit => 7
    t.string  "MSUT146b",      :limit => 7
    t.string  "MSUT147a",      :limit => 7
    t.string  "MSUT147b",      :limit => 7
    t.string  "MSUT148a",      :limit => 7
    t.string  "MSUT148b",      :limit => 7
    t.string  "MSUT149a",      :limit => 7
    t.string  "MSUT149b",      :limit => 7
    t.string  "MSUT15a",       :limit => 7
    t.string  "MSUT15b",       :limit => 7
    t.string  "MSUT150a",      :limit => 7
    t.string  "MSUT150b",      :limit => 7
    t.string  "MSUT151a",      :limit => 7
    t.string  "MSUT151b",      :limit => 7
    t.string  "MSUT152a",      :limit => 7
    t.string  "MSUT152b",      :limit => 7
    t.string  "MSUT153a",      :limit => 7
    t.string  "MSUT153b",      :limit => 7
    t.string  "MSUT154a",      :limit => 7
    t.string  "MSUT154b",      :limit => 7
    t.string  "MSUT155a",      :limit => 7
    t.string  "MSUT155b",      :limit => 7
    t.string  "MSUT156a",      :limit => 7
    t.string  "MSUT156b",      :limit => 7
    t.string  "MSUT157a",      :limit => 7
    t.string  "MSUT157b",      :limit => 7
    t.string  "MSUT158a",      :limit => 7
    t.string  "MSUT158b",      :limit => 7
    t.string  "MSUT159a",      :limit => 7
    t.string  "MSUT159b",      :limit => 7
    t.string  "MSUT16a",       :limit => 7
    t.string  "MSUT16b",       :limit => 7
    t.string  "MSUT160a",      :limit => 7
    t.string  "MSUT160b",      :limit => 7
    t.string  "MSUT161a",      :limit => 7
    t.string  "MSUT161b",      :limit => 7
    t.string  "MSUT162a",      :limit => 7
    t.string  "MSUT162b",      :limit => 7
    t.string  "MSUT163a",      :limit => 7
    t.string  "MSUT163b",      :limit => 7
    t.string  "MSUT164a",      :limit => 7
    t.string  "MSUT164b",      :limit => 7
    t.string  "MSUT165a",      :limit => 7
    t.string  "MSUT165b",      :limit => 7
    t.string  "MSUT166a",      :limit => 7
    t.string  "MSUT166b",      :limit => 7
    t.string  "MSUT167a",      :limit => 7
    t.string  "MSUT167b",      :limit => 7
    t.string  "MSUT168a",      :limit => 7
    t.string  "MSUT168b",      :limit => 7
    t.string  "MSUT169a",      :limit => 7
    t.string  "MSUT169b",      :limit => 7
    t.string  "MSUT17a",       :limit => 7
    t.string  "MSUT17b",       :limit => 7
    t.string  "MSUT170a",      :limit => 7
    t.string  "MSUT170b",      :limit => 7
    t.string  "MSUT171a",      :limit => 7
    t.string  "MSUT171b",      :limit => 7
    t.string  "MSUT172a",      :limit => 7
    t.string  "MSUT172b",      :limit => 7
    t.string  "MSUT173a",      :limit => 7
    t.string  "MSUT173b",      :limit => 7
    t.string  "MSUT174a",      :limit => 7
    t.string  "MSUT174b",      :limit => 7
    t.string  "MSUT175a",      :limit => 7
    t.string  "MSUT175b",      :limit => 7
    t.string  "MSUT176a",      :limit => 7
    t.string  "MSUT176b",      :limit => 7
    t.string  "MSUT177a",      :limit => 7
    t.string  "MSUT177b",      :limit => 7
    t.string  "MSUT178a",      :limit => 7
    t.string  "MSUT178b",      :limit => 7
    t.string  "MSUT179a",      :limit => 7
    t.string  "MSUT179b",      :limit => 7
    t.string  "MSUT18a",       :limit => 7
    t.string  "MSUT18b",       :limit => 7
    t.string  "MSUT180a",      :limit => 7
    t.string  "MSUT180b",      :limit => 7
    t.string  "MSUT181a",      :limit => 7
    t.string  "MSUT181b",      :limit => 7
    t.string  "MSUT182a",      :limit => 7
    t.string  "MSUT182b",      :limit => 7
    t.string  "MSUT183a",      :limit => 7
    t.string  "MSUT183b",      :limit => 7
    t.string  "MSUT184a",      :limit => 7
    t.string  "MSUT184b",      :limit => 7
    t.string  "MSUT185a",      :limit => 7
    t.string  "MSUT185b",      :limit => 7
    t.string  "MSUT186a",      :limit => 7
    t.string  "MSUT186b",      :limit => 7
    t.string  "MSUT187a",      :limit => 7
    t.string  "MSUT187b",      :limit => 7
    t.string  "MSUT188a",      :limit => 7
    t.string  "MSUT188b",      :limit => 7
    t.string  "MSUT189a",      :limit => 7
    t.string  "MSUT189b",      :limit => 7
    t.string  "MSUT19a",       :limit => 7
    t.string  "MSUT19b",       :limit => 7
    t.string  "MSUT190a",      :limit => 7
    t.string  "MSUT190b",      :limit => 7
    t.string  "MSUT191a",      :limit => 7
    t.string  "MSUT191b",      :limit => 7
    t.string  "MSUT192a",      :limit => 7
    t.string  "MSUT192b",      :limit => 7
    t.string  "MSUT193a",      :limit => 7
    t.string  "MSUT193b",      :limit => 7
    t.string  "MSUT194a",      :limit => 7
    t.string  "MSUT194b",      :limit => 7
    t.string  "MSUT195a",      :limit => 7
    t.string  "MSUT195b",      :limit => 7
    t.string  "MSUT196a",      :limit => 7
    t.string  "MSUT196b",      :limit => 7
    t.string  "MSUT197a",      :limit => 7
    t.string  "MSUT197b",      :limit => 7
    t.string  "MSUT198a",      :limit => 7
    t.string  "MSUT198b",      :limit => 7
    t.string  "MSUT199a",      :limit => 7
    t.string  "MSUT199b",      :limit => 7
    t.string  "MSUT20a",       :limit => 7
    t.string  "MSUT20b",       :limit => 7
    t.string  "MSUT200a",      :limit => 7
    t.string  "MSUT200b",      :limit => 7
    t.string  "MSUT201a",      :limit => 7
    t.string  "MSUT201b",      :limit => 7
    t.string  "MSUT202a",      :limit => 7
    t.string  "MSUT202b",      :limit => 7
    t.string  "MSUT203a",      :limit => 7
    t.string  "MSUT203b",      :limit => 7
    t.string  "MSUT204a",      :limit => 7
    t.string  "MSUT204b",      :limit => 7
    t.string  "MSUT205a",      :limit => 7
    t.string  "MSUT205b",      :limit => 7
    t.string  "MSUT206a",      :limit => 7
    t.string  "MSUT206b",      :limit => 7
    t.string  "MSUT207a",      :limit => 7
    t.string  "MSUT207b",      :limit => 7
    t.string  "MSUT208a",      :limit => 7
    t.string  "MSUT208b",      :limit => 7
    t.string  "MSUT209a",      :limit => 7
    t.string  "MSUT209b",      :limit => 7
    t.string  "MSUT21a",       :limit => 7
    t.string  "MSUT21b",       :limit => 7
    t.string  "MSUT210a",      :limit => 7
    t.string  "MSUT210b",      :limit => 7
    t.string  "MSUT211a",      :limit => 7
    t.string  "MSUT211b",      :limit => 7
    t.string  "MSUT212a",      :limit => 7
    t.string  "MSUT212b",      :limit => 7
    t.string  "MSUT213a",      :limit => 7
    t.string  "MSUT213b",      :limit => 7
    t.string  "MSUT214a",      :limit => 7
    t.string  "MSUT214b",      :limit => 7
    t.string  "MSUT215a",      :limit => 7
    t.string  "MSUT215b",      :limit => 7
    t.string  "MSUT216a",      :limit => 7
    t.string  "MSUT216b",      :limit => 7
    t.string  "MSUT217a",      :limit => 7
    t.string  "MSUT217b",      :limit => 7
    t.string  "MSUT218a",      :limit => 7
    t.string  "MSUT218b",      :limit => 7
    t.string  "MSUT219a",      :limit => 7
    t.string  "MSUT219b",      :limit => 7
    t.string  "MSUT22a",       :limit => 7
    t.string  "MSUT22b",       :limit => 7
    t.string  "MSUT220a",      :limit => 7
    t.string  "MSUT220b",      :limit => 7
    t.string  "MSUT221a",      :limit => 7
    t.string  "MSUT221b",      :limit => 7
    t.string  "MSUT222a",      :limit => 7
    t.string  "MSUT222b",      :limit => 7
    t.string  "MSUT223a",      :limit => 7
    t.string  "MSUT223b",      :limit => 7
    t.string  "MSUT224a",      :limit => 7
    t.string  "MSUT224b",      :limit => 7
    t.string  "MSUT225a",      :limit => 7
    t.string  "MSUT225b",      :limit => 7
    t.string  "MSUT226a",      :limit => 7
    t.string  "MSUT226b",      :limit => 7
    t.string  "MSUT227a",      :limit => 7
    t.string  "MSUT227b",      :limit => 7
    t.string  "MSUT228a",      :limit => 7
    t.string  "MSUT228b",      :limit => 7
    t.string  "MSUT229a",      :limit => 7
    t.string  "MSUT229b",      :limit => 7
    t.string  "MSUT23a",       :limit => 7
    t.string  "MSUT23b",       :limit => 7
    t.string  "MSUT230a",      :limit => 7
    t.string  "MSUT230b",      :limit => 7
    t.string  "MSUT231a",      :limit => 7
    t.string  "MSUT231b",      :limit => 7
    t.string  "MSUT232a",      :limit => 7
    t.string  "MSUT232b",      :limit => 7
    t.string  "MSUT233a",      :limit => 7
    t.string  "MSUT233b",      :limit => 7
    t.string  "MSUT234a",      :limit => 7
    t.string  "MSUT234b",      :limit => 7
    t.string  "MSUT235a",      :limit => 7
    t.string  "MSUT235b",      :limit => 7
    t.string  "MSUT236a",      :limit => 7
    t.string  "MSUT236b",      :limit => 7
    t.string  "MSUT237a",      :limit => 7
    t.string  "MSUT237b",      :limit => 7
    t.string  "MSUT238a",      :limit => 7
    t.string  "MSUT238b",      :limit => 7
    t.string  "MSUT239a",      :limit => 7
    t.string  "MSUT239b",      :limit => 7
    t.string  "MSUT24a",       :limit => 7
    t.string  "MSUT24b",       :limit => 7
    t.string  "MSUT240a",      :limit => 7
    t.string  "MSUT240b",      :limit => 7
    t.string  "MSUT241a",      :limit => 7
    t.string  "MSUT241b",      :limit => 7
    t.string  "MSUT242a",      :limit => 7
    t.string  "MSUT242b",      :limit => 7
    t.string  "MSUT243a",      :limit => 7
    t.string  "MSUT243b",      :limit => 7
    t.string  "MSUT244a",      :limit => 7
    t.string  "MSUT244b",      :limit => 7
    t.string  "MSUT245a",      :limit => 7
    t.string  "MSUT245b",      :limit => 7
    t.string  "MSUT25a",       :limit => 7
    t.string  "MSUT25b",       :limit => 7
    t.string  "MSUT26a",       :limit => 7
    t.string  "MSUT26b",       :limit => 7
    t.string  "MSUT27a",       :limit => 7
    t.string  "MSUT27b",       :limit => 7
    t.string  "MSUT28a",       :limit => 7
    t.string  "MSUT28b",       :limit => 7
    t.string  "MSUT29a",       :limit => 7
    t.string  "MSUT29b",       :limit => 7
    t.string  "MSUT30a",       :limit => 7
    t.string  "MSUT30b",       :limit => 7
    t.string  "MSUT31a",       :limit => 7
    t.string  "MSUT31b",       :limit => 7
    t.string  "MSUT32a",       :limit => 7
    t.string  "MSUT32b",       :limit => 7
    t.string  "MSUT33a",       :limit => 7
    t.string  "MSUT33b",       :limit => 7
    t.string  "MSUT34a",       :limit => 7
    t.string  "MSUT34b",       :limit => 7
    t.string  "MSUT35a",       :limit => 7
    t.string  "MSUT35b",       :limit => 7
    t.string  "MSUT36a",       :limit => 7
    t.string  "MSUT36b",       :limit => 7
    t.string  "MSUT37a",       :limit => 7
    t.string  "MSUT37b",       :limit => 7
    t.string  "MSUT38a",       :limit => 7
    t.string  "MSUT38b",       :limit => 7
    t.string  "MSUT39a",       :limit => 7
    t.string  "MSUT39b",       :limit => 7
    t.string  "MSUT40a",       :limit => 7
    t.string  "MSUT40b",       :limit => 7
    t.string  "MSUT41a",       :limit => 7
    t.string  "MSUT41b",       :limit => 7
    t.string  "MSUT42a",       :limit => 7
    t.string  "MSUT42b",       :limit => 7
    t.string  "MSUT43a",       :limit => 7
    t.string  "MSUT43b",       :limit => 7
    t.string  "MSUT44a",       :limit => 7
    t.string  "MSUT44b",       :limit => 7
    t.string  "MSUT45a",       :limit => 7
    t.string  "MSUT45b",       :limit => 7
    t.string  "MSUT46a",       :limit => 7
    t.string  "MSUT46b",       :limit => 7
    t.string  "MSUT47a",       :limit => 7
    t.string  "MSUT47b",       :limit => 7
    t.string  "MSUT48a",       :limit => 7
    t.string  "MSUT48b",       :limit => 7
    t.string  "MSUT49a",       :limit => 7
    t.string  "MSUT49b",       :limit => 7
    t.string  "MSUT50a",       :limit => 7
    t.string  "MSUT50b",       :limit => 7
    t.string  "MSUT51a",       :limit => 7
    t.string  "MSUT51b",       :limit => 7
    t.string  "MSUT52a",       :limit => 7
    t.string  "MSUT52b",       :limit => 7
    t.string  "MSUT53a",       :limit => 7
    t.string  "MSUT53b",       :limit => 7
    t.string  "MSUT54a",       :limit => 7
    t.string  "MSUT54b",       :limit => 7
    t.string  "MSUT55a",       :limit => 7
    t.string  "MSUT55b",       :limit => 7
    t.string  "MSUT56a",       :limit => 7
    t.string  "MSUT56b",       :limit => 7
    t.string  "MSUT57a",       :limit => 7
    t.string  "MSUT57b",       :limit => 7
    t.string  "MSUT58a",       :limit => 7
    t.string  "MSUT58b",       :limit => 7
    t.string  "MSUT59a",       :limit => 7
    t.string  "MSUT59b",       :limit => 7
    t.string  "MSUT6a",        :limit => 7
    t.string  "MSUT6b",        :limit => 7
    t.string  "MSUT60a",       :limit => 7
    t.string  "MSUT60b",       :limit => 7
    t.string  "MSUT61a",       :limit => 7
    t.string  "MSUT61b",       :limit => 7
    t.string  "MSUT62a",       :limit => 7
    t.string  "MSUT62b",       :limit => 7
    t.string  "MSUT63a",       :limit => 7
    t.string  "MSUT63b",       :limit => 7
    t.string  "MSUT64a",       :limit => 7
    t.string  "MSUT64b",       :limit => 7
    t.string  "MSUT65a",       :limit => 7
    t.string  "MSUT65b",       :limit => 7
    t.string  "MSUT66a",       :limit => 7
    t.string  "MSUT66b",       :limit => 7
    t.string  "MSUT67a",       :limit => 7
    t.string  "MSUT67b",       :limit => 7
    t.string  "MSUT68a",       :limit => 7
    t.string  "MSUT68b",       :limit => 7
    t.string  "MSUT69a",       :limit => 7
    t.string  "MSUT69b",       :limit => 7
    t.string  "MSUT7a",        :limit => 7
    t.string  "MSUT7b",        :limit => 7
    t.string  "MSUT70a",       :limit => 7
    t.string  "MSUT70b",       :limit => 7
    t.string  "MSUT71a",       :limit => 7
    t.string  "MSUT71b",       :limit => 7
    t.string  "MSUT72a",       :limit => 7
    t.string  "MSUT72b",       :limit => 7
    t.string  "MSUT73a",       :limit => 7
    t.string  "MSUT73b",       :limit => 7
    t.string  "MSUT74a",       :limit => 7
    t.string  "MSUT74b",       :limit => 7
    t.string  "MSUT75a",       :limit => 7
    t.string  "MSUT75b",       :limit => 7
    t.string  "MSUT76a",       :limit => 7
    t.string  "MSUT76b",       :limit => 7
    t.string  "MSUT77a",       :limit => 7
    t.string  "MSUT77b",       :limit => 7
    t.string  "MSUT78a",       :limit => 7
    t.string  "MSUT78b",       :limit => 7
    t.string  "MSUT79a",       :limit => 7
    t.string  "MSUT79b",       :limit => 7
    t.string  "MSUT8a",        :limit => 7
    t.string  "MSUT8b",        :limit => 7
    t.string  "MSUT80a",       :limit => 7
    t.string  "MSUT80b",       :limit => 7
    t.string  "MSUT81a",       :limit => 7
    t.string  "MSUT81b",       :limit => 7
    t.string  "MSUT82a",       :limit => 7
    t.string  "MSUT82b",       :limit => 7
    t.string  "MSUT83a",       :limit => 7
    t.string  "MSUT83b",       :limit => 7
    t.string  "MSUT84a",       :limit => 7
    t.string  "MSUT84b",       :limit => 7
    t.string  "MSUT85a",       :limit => 7
    t.string  "MSUT85b",       :limit => 7
    t.string  "MSUT86a",       :limit => 7
    t.string  "MSUT86b",       :limit => 7
    t.string  "MSUT87a",       :limit => 7
    t.string  "MSUT87b",       :limit => 7
    t.string  "MSUT88a",       :limit => 7
    t.string  "MSUT88b",       :limit => 7
    t.string  "MSUT89a",       :limit => 7
    t.string  "MSUT89b",       :limit => 7
    t.string  "MSUT9a",        :limit => 7
    t.string  "MSUT9b",        :limit => 7
    t.string  "MSUT90a",       :limit => 7
    t.string  "MSUT90b",       :limit => 7
    t.string  "MSUT91a",       :limit => 7
    t.string  "MSUT91b",       :limit => 7
    t.string  "MSUT92a",       :limit => 7
    t.string  "MSUT92b",       :limit => 7
    t.string  "MSUT93a",       :limit => 7
    t.string  "MSUT93b",       :limit => 7
    t.string  "MSUT94a",       :limit => 7
    t.string  "MSUT94b",       :limit => 7
    t.string  "MSUT95a",       :limit => 7
    t.string  "MSUT95b",       :limit => 7
    t.string  "MSUT96a",       :limit => 7
    t.string  "MSUT96b",       :limit => 7
    t.string  "MSUT97a",       :limit => 7
    t.string  "MSUT97b",       :limit => 7
    t.string  "MSUT98a",       :limit => 7
    t.string  "MSUT98b",       :limit => 7
    t.string  "MSUT99a",       :limit => 7
    t.string  "MSUT99b",       :limit => 7
    t.string  "MU05a",         :limit => 7
    t.string  "MU05b",         :limit => 7
    t.string  "MU50a",         :limit => 7
    t.string  "MU50b",         :limit => 7
    t.string  "MU59a",         :limit => 7
    t.string  "MU59b",         :limit => 7
    t.string  "RW18a",         :limit => 7
    t.string  "RW18b",         :limit => 7
    t.string  "RW212a",        :limit => 7
    t.string  "RW212b",        :limit => 7
    t.string  "RW217a",        :limit => 7
    t.string  "RW217b",        :limit => 7
    t.string  "RW219a",        :limit => 7
    t.string  "RW219b",        :limit => 7
    t.string  "RW25a",         :limit => 7
    t.string  "RW25b",         :limit => 7
    t.string  "RW31a",         :limit => 7
    t.string  "RW31b",         :limit => 7
    t.string  "RW34a",         :limit => 7
    t.string  "RW34b",         :limit => 7
    t.string  "RW417a",        :limit => 7
    t.string  "RW417b",        :limit => 7
    t.string  "RW45a",         :limit => 7
    t.string  "RW45b",         :limit => 7
    t.string  "RW48a",         :limit => 7
    t.string  "RW48b",         :limit => 7
    t.string  "SAM25a",        :limit => 7
    t.string  "SAM25b",        :limit => 7
    t.string  "TR2F3a",        :limit => 7
    t.string  "TR2F3b",        :limit => 7
    t.string  "TR2G5a",        :limit => 7
    t.string  "TR2G5b",        :limit => 7
    t.string  "TR3A1a",        :limit => 7
    t.string  "TR3A1b",        :limit => 7
    t.string  "TR3F2a",        :limit => 7
    t.string  "TR3F2b",        :limit => 7
    t.string  "TR3F7a",        :limit => 7
    t.string  "TR3F7b",        :limit => 7
    t.string  "TR3G1a",        :limit => 7
    t.string  "TR3G1b",        :limit => 7
    t.string  "TR3G10a",       :limit => 7
    t.string  "TR3G10b",       :limit => 7
    t.string  "TR3G11a",       :limit => 7
    t.string  "TR3G11b",       :limit => 7
    t.string  "TR3G13a",       :limit => 7
    t.string  "TR3G13b",       :limit => 7
    t.string  "TR3G2a",        :limit => 7
    t.string  "TR3G2b",        :limit => 7
    t.string  "TR3G5a",        :limit => 7
    t.string  "TR3G5b",        :limit => 7
    t.string  "TR3G6a",        :limit => 7
    t.string  "TR3G6b",        :limit => 7
    t.string  "TR3H14a",       :limit => 7
    t.string  "TR3H14b",       :limit => 7
    t.string  "TR3H4a",        :limit => 7
    t.string  "TR3H4b",        :limit => 7
    t.string  "TV14a",         :limit => 7
    t.string  "TV14b",         :limit => 7
    t.string  "TV17a",         :limit => 7
    t.string  "TV17b",         :limit => 7
    t.string  "TV19a",         :limit => 7
    t.string  "TV19b",         :limit => 7
    t.string  "TV20a",         :limit => 7
    t.string  "TV20b",         :limit => 7
  end

  create_table "microsatellite_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
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
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "MSUT10a"
    t.integer "MSUT10b"
    t.integer "MSUT100a"
    t.integer "MSUT100b"
    t.integer "MSUT101a"
    t.integer "MSUT101b"
    t.integer "MSUT102a"
    t.integer "MSUT102b"
    t.integer "MSUT103a"
    t.integer "MSUT103b"
    t.integer "MSUT104a"
    t.integer "MSUT104b"
    t.integer "MSUT105a"
    t.integer "MSUT105b"
    t.integer "MSUT106a"
    t.integer "MSUT106b"
    t.integer "MSUT107a"
    t.integer "MSUT107b"
    t.integer "MSUT108a"
    t.integer "MSUT108b"
    t.integer "MSUT109a"
    t.integer "MSUT109b"
    t.integer "MSUT11a"
    t.integer "MSUT11b"
    t.integer "MSUT110a"
    t.integer "MSUT110b"
    t.integer "MSUT111a"
    t.integer "MSUT111b"
    t.integer "MSUT112a"
    t.integer "MSUT112b"
    t.integer "MSUT113a"
    t.integer "MSUT113b"
    t.integer "MSUT114a"
    t.integer "MSUT114b"
    t.integer "MSUT115a"
    t.integer "MSUT115b"
    t.integer "MSUT116a"
    t.integer "MSUT116b"
    t.integer "MSUT117a"
    t.integer "MSUT117b"
    t.integer "MSUT118a"
    t.integer "MSUT118b"
    t.integer "MSUT119a"
    t.integer "MSUT119b"
    t.integer "MSUT12a"
    t.integer "MSUT12b"
    t.integer "MSUT120a"
    t.integer "MSUT120b"
    t.integer "MSUT121a"
    t.integer "MSUT121b"
    t.integer "MSUT122a"
    t.integer "MSUT122b"
    t.integer "MSUT123a"
    t.integer "MSUT123b"
    t.integer "MSUT124a"
    t.integer "MSUT124b"
    t.integer "MSUT125a"
    t.integer "MSUT125b"
    t.integer "MSUT126a"
    t.integer "MSUT126b"
    t.integer "MSUT127a"
    t.integer "MSUT127b"
    t.integer "MSUT128a"
    t.integer "MSUT128b"
    t.integer "MSUT129a"
    t.integer "MSUT129b"
    t.integer "MSUT13a"
    t.integer "MSUT13b"
    t.integer "MSUT130a"
    t.integer "MSUT130b"
    t.integer "MSUT131a"
    t.integer "MSUT131b"
    t.integer "MSUT132a"
    t.integer "MSUT132b"
    t.integer "MSUT133a"
    t.integer "MSUT133b"
    t.integer "MSUT134a"
    t.integer "MSUT134b"
    t.integer "MSUT135a"
    t.integer "MSUT135b"
    t.integer "MSUT136a"
    t.integer "MSUT136b"
    t.integer "MSUT137a"
    t.integer "MSUT137b"
    t.integer "MSUT138a"
    t.integer "MSUT138b"
    t.integer "MSUT139a"
    t.integer "MSUT139b"
    t.integer "MSUT14a"
    t.integer "MSUT14b"
    t.integer "MSUT140a"
    t.integer "MSUT140b"
    t.integer "MSUT141a"
    t.integer "MSUT141b"
    t.integer "MSUT142a"
    t.integer "MSUT142b"
    t.integer "MSUT143a"
    t.integer "MSUT143b"
    t.integer "MSUT144a"
    t.integer "MSUT144b"
    t.integer "MSUT145a"
    t.integer "MSUT145b"
    t.integer "MSUT146a"
    t.integer "MSUT146b"
    t.integer "MSUT147a"
    t.integer "MSUT147b"
    t.integer "MSUT148a"
    t.integer "MSUT148b"
    t.integer "MSUT149a"
    t.integer "MSUT149b"
    t.integer "MSUT15a"
    t.integer "MSUT15b"
    t.integer "MSUT150a"
    t.integer "MSUT150b"
    t.integer "MSUT151a"
    t.integer "MSUT151b"
    t.integer "MSUT152a"
    t.integer "MSUT152b"
    t.integer "MSUT153a"
    t.integer "MSUT153b"
    t.integer "MSUT154a"
    t.integer "MSUT154b"
    t.integer "MSUT155a"
    t.integer "MSUT155b"
    t.integer "MSUT156a"
    t.integer "MSUT156b"
    t.integer "MSUT157a"
    t.integer "MSUT157b"
    t.integer "MSUT158a"
    t.integer "MSUT158b"
    t.integer "MSUT159a"
    t.integer "MSUT159b"
    t.integer "MSUT16a"
    t.integer "MSUT16b"
    t.integer "MSUT160a"
    t.integer "MSUT160b"
    t.integer "MSUT161a"
    t.integer "MSUT161b"
    t.integer "MSUT162a"
    t.integer "MSUT162b"
    t.integer "MSUT163a"
    t.integer "MSUT163b"
    t.integer "MSUT164a"
    t.integer "MSUT164b"
    t.integer "MSUT165a"
    t.integer "MSUT165b"
    t.integer "MSUT166a"
    t.integer "MSUT166b"
    t.integer "MSUT167a"
    t.integer "MSUT167b"
    t.integer "MSUT168a"
    t.integer "MSUT168b"
    t.integer "MSUT169a"
    t.integer "MSUT169b"
    t.integer "MSUT17a"
    t.integer "MSUT17b"
    t.integer "MSUT170a"
    t.integer "MSUT170b"
    t.integer "MSUT171a"
    t.integer "MSUT171b"
    t.integer "MSUT172a"
    t.integer "MSUT172b"
    t.integer "MSUT173a"
    t.integer "MSUT173b"
    t.integer "MSUT174a"
    t.integer "MSUT174b"
    t.integer "MSUT175a"
    t.integer "MSUT175b"
    t.integer "MSUT176a"
    t.integer "MSUT176b"
    t.integer "MSUT177a"
    t.integer "MSUT177b"
    t.integer "MSUT178a"
    t.integer "MSUT178b"
    t.integer "MSUT179a"
    t.integer "MSUT179b"
    t.integer "MSUT18a"
    t.integer "MSUT18b"
    t.integer "MSUT180a"
    t.integer "MSUT180b"
    t.integer "MSUT181a"
    t.integer "MSUT181b"
    t.integer "MSUT182a"
    t.integer "MSUT182b"
    t.integer "MSUT183a"
    t.integer "MSUT183b"
    t.integer "MSUT184a"
    t.integer "MSUT184b"
    t.integer "MSUT185a"
    t.integer "MSUT185b"
    t.integer "MSUT186a"
    t.integer "MSUT186b"
    t.integer "MSUT187a"
    t.integer "MSUT187b"
    t.integer "MSUT188a"
    t.integer "MSUT188b"
    t.integer "MSUT189a"
    t.integer "MSUT189b"
    t.integer "MSUT19a"
    t.integer "MSUT19b"
    t.integer "MSUT190a"
    t.integer "MSUT190b"
    t.integer "MSUT191a"
    t.integer "MSUT191b"
    t.integer "MSUT192a"
    t.integer "MSUT192b"
    t.integer "MSUT193a"
    t.integer "MSUT193b"
    t.integer "MSUT194a"
    t.integer "MSUT194b"
    t.integer "MSUT195a"
    t.integer "MSUT195b"
    t.integer "MSUT196a"
    t.integer "MSUT196b"
    t.integer "MSUT197a"
    t.integer "MSUT197b"
    t.integer "MSUT198a"
    t.integer "MSUT198b"
    t.integer "MSUT199a"
    t.integer "MSUT199b"
    t.integer "MSUT20a"
    t.integer "MSUT20b"
    t.integer "MSUT200a"
    t.integer "MSUT200b"
    t.integer "MSUT201a"
    t.integer "MSUT201b"
    t.integer "MSUT202a"
    t.integer "MSUT202b"
    t.integer "MSUT203a"
    t.integer "MSUT203b"
    t.integer "MSUT204a"
    t.integer "MSUT204b"
    t.integer "MSUT205a"
    t.integer "MSUT205b"
    t.integer "MSUT206a"
    t.integer "MSUT206b"
    t.integer "MSUT207a"
    t.integer "MSUT207b"
    t.integer "MSUT208a"
    t.integer "MSUT208b"
    t.integer "MSUT209a"
    t.integer "MSUT209b"
    t.integer "MSUT21a"
    t.integer "MSUT21b"
    t.integer "MSUT210a"
    t.integer "MSUT210b"
    t.integer "MSUT211a"
    t.integer "MSUT211b"
    t.integer "MSUT212a"
    t.integer "MSUT212b"
    t.integer "MSUT213a"
    t.integer "MSUT213b"
    t.integer "MSUT214a"
    t.integer "MSUT214b"
    t.integer "MSUT215a"
    t.integer "MSUT215b"
    t.integer "MSUT216a"
    t.integer "MSUT216b"
    t.integer "MSUT217a"
    t.integer "MSUT217b"
    t.integer "MSUT218a"
    t.integer "MSUT218b"
    t.integer "MSUT219a"
    t.integer "MSUT219b"
    t.integer "MSUT22a"
    t.integer "MSUT22b"
    t.integer "MSUT220a"
    t.integer "MSUT220b"
    t.integer "MSUT221a"
    t.integer "MSUT221b"
    t.integer "MSUT222a"
    t.integer "MSUT222b"
    t.integer "MSUT223a"
    t.integer "MSUT223b"
    t.integer "MSUT224a"
    t.integer "MSUT224b"
    t.integer "MSUT225a"
    t.integer "MSUT225b"
    t.integer "MSUT226a"
    t.integer "MSUT226b"
    t.integer "MSUT227a"
    t.integer "MSUT227b"
    t.integer "MSUT228a"
    t.integer "MSUT228b"
    t.integer "MSUT229a"
    t.integer "MSUT229b"
    t.integer "MSUT23a"
    t.integer "MSUT23b"
    t.integer "MSUT230a"
    t.integer "MSUT230b"
    t.integer "MSUT231a"
    t.integer "MSUT231b"
    t.integer "MSUT232a"
    t.integer "MSUT232b"
    t.integer "MSUT233a"
    t.integer "MSUT233b"
    t.integer "MSUT234a"
    t.integer "MSUT234b"
    t.integer "MSUT235a"
    t.integer "MSUT235b"
    t.integer "MSUT236a"
    t.integer "MSUT236b"
    t.integer "MSUT237a"
    t.integer "MSUT237b"
    t.integer "MSUT238a"
    t.integer "MSUT238b"
    t.integer "MSUT239a"
    t.integer "MSUT239b"
    t.integer "MSUT24a"
    t.integer "MSUT24b"
    t.integer "MSUT240a"
    t.integer "MSUT240b"
    t.integer "MSUT241a"
    t.integer "MSUT241b"
    t.integer "MSUT242a"
    t.integer "MSUT242b"
    t.integer "MSUT243a"
    t.integer "MSUT243b"
    t.integer "MSUT244a"
    t.integer "MSUT244b"
    t.integer "MSUT245a"
    t.integer "MSUT245b"
    t.integer "MSUT25a"
    t.integer "MSUT25b"
    t.integer "MSUT26a"
    t.integer "MSUT26b"
    t.integer "MSUT27a"
    t.integer "MSUT27b"
    t.integer "MSUT28a"
    t.integer "MSUT28b"
    t.integer "MSUT29a"
    t.integer "MSUT29b"
    t.integer "MSUT30a"
    t.integer "MSUT30b"
    t.integer "MSUT31a"
    t.integer "MSUT31b"
    t.integer "MSUT32a"
    t.integer "MSUT32b"
    t.integer "MSUT33a"
    t.integer "MSUT33b"
    t.integer "MSUT34a"
    t.integer "MSUT34b"
    t.integer "MSUT35a"
    t.integer "MSUT35b"
    t.integer "MSUT36a"
    t.integer "MSUT36b"
    t.integer "MSUT37a"
    t.integer "MSUT37b"
    t.integer "MSUT38a"
    t.integer "MSUT38b"
    t.integer "MSUT39a"
    t.integer "MSUT39b"
    t.integer "MSUT40a"
    t.integer "MSUT40b"
    t.integer "MSUT41a"
    t.integer "MSUT41b"
    t.integer "MSUT42a"
    t.integer "MSUT42b"
    t.integer "MSUT43a"
    t.integer "MSUT43b"
    t.integer "MSUT44a"
    t.integer "MSUT44b"
    t.integer "MSUT45a"
    t.integer "MSUT45b"
    t.integer "MSUT46a"
    t.integer "MSUT46b"
    t.integer "MSUT47a"
    t.integer "MSUT47b"
    t.integer "MSUT48a"
    t.integer "MSUT48b"
    t.integer "MSUT49a"
    t.integer "MSUT49b"
    t.integer "MSUT50a"
    t.integer "MSUT50b"
    t.integer "MSUT51a"
    t.integer "MSUT51b"
    t.integer "MSUT52a"
    t.integer "MSUT52b"
    t.integer "MSUT53a"
    t.integer "MSUT53b"
    t.integer "MSUT54a"
    t.integer "MSUT54b"
    t.integer "MSUT55a"
    t.integer "MSUT55b"
    t.integer "MSUT56a"
    t.integer "MSUT56b"
    t.integer "MSUT57a"
    t.integer "MSUT57b"
    t.integer "MSUT58a"
    t.integer "MSUT58b"
    t.integer "MSUT59a"
    t.integer "MSUT59b"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MSUT60a"
    t.integer "MSUT60b"
    t.integer "MSUT61a"
    t.integer "MSUT61b"
    t.integer "MSUT62a"
    t.integer "MSUT62b"
    t.integer "MSUT63a"
    t.integer "MSUT63b"
    t.integer "MSUT64a"
    t.integer "MSUT64b"
    t.integer "MSUT65a"
    t.integer "MSUT65b"
    t.integer "MSUT66a"
    t.integer "MSUT66b"
    t.integer "MSUT67a"
    t.integer "MSUT67b"
    t.integer "MSUT68a"
    t.integer "MSUT68b"
    t.integer "MSUT69a"
    t.integer "MSUT69b"
    t.integer "MSUT7a"
    t.integer "MSUT7b"
    t.integer "MSUT70a"
    t.integer "MSUT70b"
    t.integer "MSUT71a"
    t.integer "MSUT71b"
    t.integer "MSUT72a"
    t.integer "MSUT72b"
    t.integer "MSUT73a"
    t.integer "MSUT73b"
    t.integer "MSUT74a"
    t.integer "MSUT74b"
    t.integer "MSUT75a"
    t.integer "MSUT75b"
    t.integer "MSUT76a"
    t.integer "MSUT76b"
    t.integer "MSUT77a"
    t.integer "MSUT77b"
    t.integer "MSUT78a"
    t.integer "MSUT78b"
    t.integer "MSUT79a"
    t.integer "MSUT79b"
    t.integer "MSUT8a"
    t.integer "MSUT8b"
    t.integer "MSUT80a"
    t.integer "MSUT80b"
    t.integer "MSUT81a"
    t.integer "MSUT81b"
    t.integer "MSUT82a"
    t.integer "MSUT82b"
    t.integer "MSUT83a"
    t.integer "MSUT83b"
    t.integer "MSUT84a"
    t.integer "MSUT84b"
    t.integer "MSUT85a"
    t.integer "MSUT85b"
    t.integer "MSUT86a"
    t.integer "MSUT86b"
    t.integer "MSUT87a"
    t.integer "MSUT87b"
    t.integer "MSUT88a"
    t.integer "MSUT88b"
    t.integer "MSUT89a"
    t.integer "MSUT89b"
    t.integer "MSUT9a"
    t.integer "MSUT9b"
    t.integer "MSUT90a"
    t.integer "MSUT90b"
    t.integer "MSUT91a"
    t.integer "MSUT91b"
    t.integer "MSUT92a"
    t.integer "MSUT92b"
    t.integer "MSUT93a"
    t.integer "MSUT93b"
    t.integer "MSUT94a"
    t.integer "MSUT94b"
    t.integer "MSUT95a"
    t.integer "MSUT95b"
    t.integer "MSUT96a"
    t.integer "MSUT96b"
    t.integer "MSUT97a"
    t.integer "MSUT97b"
    t.integer "MSUT98a"
    t.integer "MSUT98b"
    t.integer "MSUT99a"
    t.integer "MSUT99b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU59a"
    t.integer "MU59b"
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
    t.string  "organism_code"
    t.integer "org_sample"
    t.integer "allelea"
    t.integer "alleleb"
  end

  create_table "microsatellite_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "sample_id"
    t.integer "organism_index"
    t.integer "EV1Pma"
    t.integer "EV1Pmb"
    t.integer "EV37Mna"
    t.integer "EV37Mnb"
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
    t.integer "GATA028a"
    t.integer "GATA028b"
    t.integer "GT023a"
    t.integer "GT023b"
    t.integer "GT271a"
    t.integer "GT271b"
    t.integer "IGFa"
    t.integer "IGFb"
    t.integer "MSUT10a"
    t.integer "MSUT10b"
    t.integer "MSUT100a"
    t.integer "MSUT100b"
    t.integer "MSUT101a"
    t.integer "MSUT101b"
    t.integer "MSUT102a"
    t.integer "MSUT102b"
    t.integer "MSUT103a"
    t.integer "MSUT103b"
    t.integer "MSUT104a"
    t.integer "MSUT104b"
    t.integer "MSUT105a"
    t.integer "MSUT105b"
    t.integer "MSUT106a"
    t.integer "MSUT106b"
    t.integer "MSUT107a"
    t.integer "MSUT107b"
    t.integer "MSUT108a"
    t.integer "MSUT108b"
    t.integer "MSUT109a"
    t.integer "MSUT109b"
    t.integer "MSUT11a"
    t.integer "MSUT11b"
    t.integer "MSUT110a"
    t.integer "MSUT110b"
    t.integer "MSUT111a"
    t.integer "MSUT111b"
    t.integer "MSUT112a"
    t.integer "MSUT112b"
    t.integer "MSUT113a"
    t.integer "MSUT113b"
    t.integer "MSUT114a"
    t.integer "MSUT114b"
    t.integer "MSUT115a"
    t.integer "MSUT115b"
    t.integer "MSUT116a"
    t.integer "MSUT116b"
    t.integer "MSUT117a"
    t.integer "MSUT117b"
    t.integer "MSUT118a"
    t.integer "MSUT118b"
    t.integer "MSUT119a"
    t.integer "MSUT119b"
    t.integer "MSUT12a"
    t.integer "MSUT12b"
    t.integer "MSUT120a"
    t.integer "MSUT120b"
    t.integer "MSUT121a"
    t.integer "MSUT121b"
    t.integer "MSUT122a"
    t.integer "MSUT122b"
    t.integer "MSUT123a"
    t.integer "MSUT123b"
    t.integer "MSUT124a"
    t.integer "MSUT124b"
    t.integer "MSUT125a"
    t.integer "MSUT125b"
    t.integer "MSUT126a"
    t.integer "MSUT126b"
    t.integer "MSUT127a"
    t.integer "MSUT127b"
    t.integer "MSUT128a"
    t.integer "MSUT128b"
    t.integer "MSUT129a"
    t.integer "MSUT129b"
    t.integer "MSUT13a"
    t.integer "MSUT13b"
    t.integer "MSUT130a"
    t.integer "MSUT130b"
    t.integer "MSUT131a"
    t.integer "MSUT131b"
    t.integer "MSUT132a"
    t.integer "MSUT132b"
    t.integer "MSUT133a"
    t.integer "MSUT133b"
    t.integer "MSUT134a"
    t.integer "MSUT134b"
    t.integer "MSUT135a"
    t.integer "MSUT135b"
    t.integer "MSUT136a"
    t.integer "MSUT136b"
    t.integer "MSUT137a"
    t.integer "MSUT137b"
    t.integer "MSUT138a"
    t.integer "MSUT138b"
    t.integer "MSUT139a"
    t.integer "MSUT139b"
    t.integer "MSUT14a"
    t.integer "MSUT14b"
    t.integer "MSUT140a"
    t.integer "MSUT140b"
    t.integer "MSUT141a"
    t.integer "MSUT141b"
    t.integer "MSUT142a"
    t.integer "MSUT142b"
    t.integer "MSUT143a"
    t.integer "MSUT143b"
    t.integer "MSUT144a"
    t.integer "MSUT144b"
    t.integer "MSUT145a"
    t.integer "MSUT145b"
    t.integer "MSUT146a"
    t.integer "MSUT146b"
    t.integer "MSUT147a"
    t.integer "MSUT147b"
    t.integer "MSUT148a"
    t.integer "MSUT148b"
    t.integer "MSUT149a"
    t.integer "MSUT149b"
    t.integer "MSUT15a"
    t.integer "MSUT15b"
    t.integer "MSUT150a"
    t.integer "MSUT150b"
    t.integer "MSUT151a"
    t.integer "MSUT151b"
    t.integer "MSUT152a"
    t.integer "MSUT152b"
    t.integer "MSUT153a"
    t.integer "MSUT153b"
    t.integer "MSUT154a"
    t.integer "MSUT154b"
    t.integer "MSUT155a"
    t.integer "MSUT155b"
    t.integer "MSUT156a"
    t.integer "MSUT156b"
    t.integer "MSUT157a"
    t.integer "MSUT157b"
    t.integer "MSUT158a"
    t.integer "MSUT158b"
    t.integer "MSUT159a"
    t.integer "MSUT159b"
    t.integer "MSUT16a"
    t.integer "MSUT16b"
    t.integer "MSUT160a"
    t.integer "MSUT160b"
    t.integer "MSUT161a"
    t.integer "MSUT161b"
    t.integer "MSUT162a"
    t.integer "MSUT162b"
    t.integer "MSUT163a"
    t.integer "MSUT163b"
    t.integer "MSUT164a"
    t.integer "MSUT164b"
    t.integer "MSUT165a"
    t.integer "MSUT165b"
    t.integer "MSUT166a"
    t.integer "MSUT166b"
    t.integer "MSUT167a"
    t.integer "MSUT167b"
    t.integer "MSUT168a"
    t.integer "MSUT168b"
    t.integer "MSUT169a"
    t.integer "MSUT169b"
    t.integer "MSUT17a"
    t.integer "MSUT17b"
    t.integer "MSUT170a"
    t.integer "MSUT170b"
    t.integer "MSUT171a"
    t.integer "MSUT171b"
    t.integer "MSUT172a"
    t.integer "MSUT172b"
    t.integer "MSUT173a"
    t.integer "MSUT173b"
    t.integer "MSUT174a"
    t.integer "MSUT174b"
    t.integer "MSUT175a"
    t.integer "MSUT175b"
    t.integer "MSUT176a"
    t.integer "MSUT176b"
    t.integer "MSUT177a"
    t.integer "MSUT177b"
    t.integer "MSUT178a"
    t.integer "MSUT178b"
    t.integer "MSUT179a"
    t.integer "MSUT179b"
    t.integer "MSUT18a"
    t.integer "MSUT18b"
    t.integer "MSUT180a"
    t.integer "MSUT180b"
    t.integer "MSUT181a"
    t.integer "MSUT181b"
    t.integer "MSUT182a"
    t.integer "MSUT182b"
    t.integer "MSUT183a"
    t.integer "MSUT183b"
    t.integer "MSUT184a"
    t.integer "MSUT184b"
    t.integer "MSUT185a"
    t.integer "MSUT185b"
    t.integer "MSUT186a"
    t.integer "MSUT186b"
    t.integer "MSUT187a"
    t.integer "MSUT187b"
    t.integer "MSUT188a"
    t.integer "MSUT188b"
    t.integer "MSUT189a"
    t.integer "MSUT189b"
    t.integer "MSUT19a"
    t.integer "MSUT19b"
    t.integer "MSUT190a"
    t.integer "MSUT190b"
    t.integer "MSUT191a"
    t.integer "MSUT191b"
    t.integer "MSUT192a"
    t.integer "MSUT192b"
    t.integer "MSUT193a"
    t.integer "MSUT193b"
    t.integer "MSUT194a"
    t.integer "MSUT194b"
    t.integer "MSUT195a"
    t.integer "MSUT195b"
    t.integer "MSUT196a"
    t.integer "MSUT196b"
    t.integer "MSUT197a"
    t.integer "MSUT197b"
    t.integer "MSUT198a"
    t.integer "MSUT198b"
    t.integer "MSUT199a"
    t.integer "MSUT199b"
    t.integer "MSUT20a"
    t.integer "MSUT20b"
    t.integer "MSUT200a"
    t.integer "MSUT200b"
    t.integer "MSUT201a"
    t.integer "MSUT201b"
    t.integer "MSUT202a"
    t.integer "MSUT202b"
    t.integer "MSUT203a"
    t.integer "MSUT203b"
    t.integer "MSUT204a"
    t.integer "MSUT204b"
    t.integer "MSUT205a"
    t.integer "MSUT205b"
    t.integer "MSUT206a"
    t.integer "MSUT206b"
    t.integer "MSUT207a"
    t.integer "MSUT207b"
    t.integer "MSUT208a"
    t.integer "MSUT208b"
    t.integer "MSUT209a"
    t.integer "MSUT209b"
    t.integer "MSUT21a"
    t.integer "MSUT21b"
    t.integer "MSUT210a"
    t.integer "MSUT210b"
    t.integer "MSUT211a"
    t.integer "MSUT211b"
    t.integer "MSUT212a"
    t.integer "MSUT212b"
    t.integer "MSUT213a"
    t.integer "MSUT213b"
    t.integer "MSUT214a"
    t.integer "MSUT214b"
    t.integer "MSUT215a"
    t.integer "MSUT215b"
    t.integer "MSUT216a"
    t.integer "MSUT216b"
    t.integer "MSUT217a"
    t.integer "MSUT217b"
    t.integer "MSUT218a"
    t.integer "MSUT218b"
    t.integer "MSUT219a"
    t.integer "MSUT219b"
    t.integer "MSUT22a"
    t.integer "MSUT22b"
    t.integer "MSUT220a"
    t.integer "MSUT220b"
    t.integer "MSUT221a"
    t.integer "MSUT221b"
    t.integer "MSUT222a"
    t.integer "MSUT222b"
    t.integer "MSUT223a"
    t.integer "MSUT223b"
    t.integer "MSUT224a"
    t.integer "MSUT224b"
    t.integer "MSUT225a"
    t.integer "MSUT225b"
    t.integer "MSUT226a"
    t.integer "MSUT226b"
    t.integer "MSUT227a"
    t.integer "MSUT227b"
    t.integer "MSUT228a"
    t.integer "MSUT228b"
    t.integer "MSUT229a"
    t.integer "MSUT229b"
    t.integer "MSUT23a"
    t.integer "MSUT23b"
    t.integer "MSUT230a"
    t.integer "MSUT230b"
    t.integer "MSUT231a"
    t.integer "MSUT231b"
    t.integer "MSUT232a"
    t.integer "MSUT232b"
    t.integer "MSUT233a"
    t.integer "MSUT233b"
    t.integer "MSUT234a"
    t.integer "MSUT234b"
    t.integer "MSUT235a"
    t.integer "MSUT235b"
    t.integer "MSUT236a"
    t.integer "MSUT236b"
    t.integer "MSUT237a"
    t.integer "MSUT237b"
    t.integer "MSUT238a"
    t.integer "MSUT238b"
    t.integer "MSUT239a"
    t.integer "MSUT239b"
    t.integer "MSUT24a"
    t.integer "MSUT24b"
    t.integer "MSUT240a"
    t.integer "MSUT240b"
    t.integer "MSUT241a"
    t.integer "MSUT241b"
    t.integer "MSUT242a"
    t.integer "MSUT242b"
    t.integer "MSUT243a"
    t.integer "MSUT243b"
    t.integer "MSUT244a"
    t.integer "MSUT244b"
    t.integer "MSUT245a"
    t.integer "MSUT245b"
    t.integer "MSUT25a"
    t.integer "MSUT25b"
    t.integer "MSUT26a"
    t.integer "MSUT26b"
    t.integer "MSUT27a"
    t.integer "MSUT27b"
    t.integer "MSUT28a"
    t.integer "MSUT28b"
    t.integer "MSUT29a"
    t.integer "MSUT29b"
    t.integer "MSUT30a"
    t.integer "MSUT30b"
    t.integer "MSUT31a"
    t.integer "MSUT31b"
    t.integer "MSUT32a"
    t.integer "MSUT32b"
    t.integer "MSUT33a"
    t.integer "MSUT33b"
    t.integer "MSUT34a"
    t.integer "MSUT34b"
    t.integer "MSUT35a"
    t.integer "MSUT35b"
    t.integer "MSUT36a"
    t.integer "MSUT36b"
    t.integer "MSUT37a"
    t.integer "MSUT37b"
    t.integer "MSUT38a"
    t.integer "MSUT38b"
    t.integer "MSUT39a"
    t.integer "MSUT39b"
    t.integer "MSUT40a"
    t.integer "MSUT40b"
    t.integer "MSUT41a"
    t.integer "MSUT41b"
    t.integer "MSUT42a"
    t.integer "MSUT42b"
    t.integer "MSUT43a"
    t.integer "MSUT43b"
    t.integer "MSUT44a"
    t.integer "MSUT44b"
    t.integer "MSUT45a"
    t.integer "MSUT45b"
    t.integer "MSUT46a"
    t.integer "MSUT46b"
    t.integer "MSUT47a"
    t.integer "MSUT47b"
    t.integer "MSUT48a"
    t.integer "MSUT48b"
    t.integer "MSUT49a"
    t.integer "MSUT49b"
    t.integer "MSUT50a"
    t.integer "MSUT50b"
    t.integer "MSUT51a"
    t.integer "MSUT51b"
    t.integer "MSUT52a"
    t.integer "MSUT52b"
    t.integer "MSUT53a"
    t.integer "MSUT53b"
    t.integer "MSUT54a"
    t.integer "MSUT54b"
    t.integer "MSUT55a"
    t.integer "MSUT55b"
    t.integer "MSUT56a"
    t.integer "MSUT56b"
    t.integer "MSUT57a"
    t.integer "MSUT57b"
    t.integer "MSUT58a"
    t.integer "MSUT58b"
    t.integer "MSUT59a"
    t.integer "MSUT59b"
    t.integer "MSUT6a"
    t.integer "MSUT6b"
    t.integer "MSUT60a"
    t.integer "MSUT60b"
    t.integer "MSUT61a"
    t.integer "MSUT61b"
    t.integer "MSUT62a"
    t.integer "MSUT62b"
    t.integer "MSUT63a"
    t.integer "MSUT63b"
    t.integer "MSUT64a"
    t.integer "MSUT64b"
    t.integer "MSUT65a"
    t.integer "MSUT65b"
    t.integer "MSUT66a"
    t.integer "MSUT66b"
    t.integer "MSUT67a"
    t.integer "MSUT67b"
    t.integer "MSUT68a"
    t.integer "MSUT68b"
    t.integer "MSUT69a"
    t.integer "MSUT69b"
    t.integer "MSUT7a"
    t.integer "MSUT7b"
    t.integer "MSUT70a"
    t.integer "MSUT70b"
    t.integer "MSUT71a"
    t.integer "MSUT71b"
    t.integer "MSUT72a"
    t.integer "MSUT72b"
    t.integer "MSUT73a"
    t.integer "MSUT73b"
    t.integer "MSUT74a"
    t.integer "MSUT74b"
    t.integer "MSUT75a"
    t.integer "MSUT75b"
    t.integer "MSUT76a"
    t.integer "MSUT76b"
    t.integer "MSUT77a"
    t.integer "MSUT77b"
    t.integer "MSUT78a"
    t.integer "MSUT78b"
    t.integer "MSUT79a"
    t.integer "MSUT79b"
    t.integer "MSUT8a"
    t.integer "MSUT8b"
    t.integer "MSUT80a"
    t.integer "MSUT80b"
    t.integer "MSUT81a"
    t.integer "MSUT81b"
    t.integer "MSUT82a"
    t.integer "MSUT82b"
    t.integer "MSUT83a"
    t.integer "MSUT83b"
    t.integer "MSUT84a"
    t.integer "MSUT84b"
    t.integer "MSUT85a"
    t.integer "MSUT85b"
    t.integer "MSUT86a"
    t.integer "MSUT86b"
    t.integer "MSUT87a"
    t.integer "MSUT87b"
    t.integer "MSUT88a"
    t.integer "MSUT88b"
    t.integer "MSUT89a"
    t.integer "MSUT89b"
    t.integer "MSUT9a"
    t.integer "MSUT9b"
    t.integer "MSUT90a"
    t.integer "MSUT90b"
    t.integer "MSUT91a"
    t.integer "MSUT91b"
    t.integer "MSUT92a"
    t.integer "MSUT92b"
    t.integer "MSUT93a"
    t.integer "MSUT93b"
    t.integer "MSUT94a"
    t.integer "MSUT94b"
    t.integer "MSUT95a"
    t.integer "MSUT95b"
    t.integer "MSUT96a"
    t.integer "MSUT96b"
    t.integer "MSUT97a"
    t.integer "MSUT97b"
    t.integer "MSUT98a"
    t.integer "MSUT98b"
    t.integer "MSUT99a"
    t.integer "MSUT99b"
    t.integer "MU05a"
    t.integer "MU05b"
    t.integer "MU50a"
    t.integer "MU50b"
    t.integer "MU59a"
    t.integer "MU59b"
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
    t.string  "locus",       :limit => 30
    t.integer "allele1"
    t.integer "allele2"
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
  end

  create_table "mt_dna_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code",  :limit => 128
    t.string  "Control Region"
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
    t.string  "haplotype",   :limit => 12
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

  create_table "queries", :force => true do |t|
    t.integer  "project_id"
    t.string   "name",       :limit => 100
    t.boolean  "draft",                     :default => true
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "samples", :force => true do |t|
    t.integer  "project_id"
    t.integer  "organism_id"
    t.string   "organism_index"
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
    t.string   "UTM_datum"
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
    t.boolean  "is_admin",                                :default => false
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

  create_table "y_chromosome_final_horizontals_2", :force => true do |t|
    t.integer "project_id"
    t.integer "organism_id"
    t.string  "organism_code", :limit => 128
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
