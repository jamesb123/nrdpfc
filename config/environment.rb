# Be sure to restart your web server when you modify this file.
# require 'thread'
# DO NOT REMOVE THIS LINE - It's important for the fcgid deployment we are using.
begin
  ENV['RAILS_SITE'] = "TRACKER"
  ENV['RAILS_ENV'] = File.read("config/RAILS_ENV").strip if ENV['RAILS_ENV'] == 'production'
  ENV['RAILS_SITE'] = File.read("config/RAILS_SITE").strip 

rescue 
end
# Query Builder output limit
QB_OUTPUT_LIMIT = 2000
# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION
# RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION
# RAILS_GEM_VERSION = '2.3.9' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
  config.gem 'hoptoad_notifier'
#  config.gem 'paperclip', :version => "2.7.0"
  config.gem "fastercsv"
  config.gem "newrelic_rpm" 
  config.action_controller.session_store = :active_record_store
  config.action_controller.session = { :key => "_nrdpfc", :secret => ("_nrdpfc!!!!!!!" * 10) }

  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
#  config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )
#  config.gem "factory_girl"

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
#  config.DT = [["",""],["Resolved (genetic)","Resolved (genetic)"],["Resolved (Photo ID)","Resolved (Photo ID)"], ["Resolved (sample labelling/tracking)","Resolved (sample labelling/tracking)"], ["Resolved (unknown cause)","Resolved (unknown cause)"],["In Progress","In Progress"]]

end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below
Dir["#{RAILS_ROOT}/lib/overrides/*"].each {| file | require file }

def dbg; require "ruby-debug"; debugger; end;

if RAILS_ENV=='test'
  require "#{RAILS_ROOT}/test/rselenese_helpers.rb"
end

# SCRIPT_LINES__ = {} if ENV['RAILS_ENV'] == 'development'


require "fastercsv"
load "#{RAILS_ROOT}/app/models/dynamic_attribute.rb" # manually require this because we want to inject some more code into the model that comes with the dynamic_attribute plugin.
# require 'paginator'
  
::RESULT_TABLES = %w[genders microsatellites mhcs mt_dnas y_chromosomes surveys sightings]

# Fixes problems with ruby 1.8.7
unless '1.9'.respond_to?(:force_encoding)
  String.class_eval do
    begin
      remove_method :chars
    rescue NameError # OK
    end
  end
end

# define this in your environment.rb
# Default date/time format
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => "%Y.%m.%d")
# ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => "%H:%M,:%S")
ActiveSupport::Deprecation.silenced = true
