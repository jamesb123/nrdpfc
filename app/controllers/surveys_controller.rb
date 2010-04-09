class SurveysController < ApplicationController
  layout "tabs"
  active_scaffold :surveys do |config|
    config.columns = [:survey_date, :survey_time, :interval, :latitude]
  end
end
