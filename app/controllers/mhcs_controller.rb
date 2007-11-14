class MhcsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhcs do |config|
    config.columns = [:id, :project, :sample, :locus, :allele1, :allele2, :gelNum, :wellNum, :finalResult, :security_settings]
    config.create.columns.exclude :sample, :project, :security_settings
    config.update.columns.exclude :sample, :project, :security_settings

    config.columns[:sample].label = "Sample Info"
    config.columns[:allele1].label = "Allele 1"
    config.columns[:allele2].label = "Allele 2"    
    config.columns[:gelNum].label = "Gel Num"
  end

end
  def conditions_for_collection
    ['samples.project_id = (?)', current_user.current_project]
  end
