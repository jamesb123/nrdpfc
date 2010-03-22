class SurveysController < ApplicationController
  layout "tabs"
  active_scaffold :surveys do |config|
    config.columns = [:interval, :latitude]
  end
end
