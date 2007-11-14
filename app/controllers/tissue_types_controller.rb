class TissueTypesController < ApplicationController
  layout "tabs"
  active_scaffold :tissue_types do |config|
    config.columns = [:tissue_type, :comment]
    
  end
end
