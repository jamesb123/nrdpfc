class TissueTypesController < ApplicationController
  layout "tabs"
  active_scaffold :tissue_types do |config|
    config.columns = [:tissue_desc, :comment]
  end
end
