class ShippingmaterialsController < ApplicationController
  layout "tabs"
  active_scaffold :shippingmaterials do |config|
    config.columns = [:medium_short_desc, :medium_long_desc]  
    config.columns[:medium_short_desc].label = "Short Description"  
    config.columns[:medium_long_desc].label = "Long Description"  
  end
end
