class ExtractionMethodsController < ApplicationController
  layout "tabs"
  active_scaffold :extractionMethods do |config|
    config.columns = [:extraction_method_name, :extraction_method_description]  
    # config.columns[:sample].label = "Sample Info"  
  end
end
