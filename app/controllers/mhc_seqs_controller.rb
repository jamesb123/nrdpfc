class MhcSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhc_seqs do |config|
    config.columns = [:project, :locus, :allele, :sequence, :accession ]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
  end 

  def conditions_for_collection
    ['mhc_seqs.project_id = (?)', current_project_id ]
  end

  
end
