class YChromosomesController < ApplicationController
  layout "tabs"
  active_scaffold :YChromosomes do |config|
    config.columns = [:project, :sample, :locus, :haplotype, :finalResult]
    
    config.create.columns.exclude :id, :project, :sample
    config.update.columns.exclude :id, :project, :sample
    config.list.columns.exclude :security_settings
  end
end
