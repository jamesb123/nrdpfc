# this can be quicker to run than rake:test because it doesn't reconstruct the entire 
# database from the schema.rb file (something that takes a long time to do)
["unit", "functional", "integration"].each{|test_type|
  Dir[File.dirname(__FILE__) + "/#{test_type}/**/*.rb"].each { |file| require(file) }
}
