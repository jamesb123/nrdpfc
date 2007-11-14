class LocalityTypesController < ApplicationController
  layout "tabs"
  active_scaffold :locality_types do |config|
    config.columns = [:locality_type_name, :locality_type_desc]
  end
end
