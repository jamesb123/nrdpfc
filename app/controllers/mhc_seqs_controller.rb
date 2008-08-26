class MhcSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mhc_seqs do |config|
    config.columns = [:project, :locus, :allele, :sequence, :accession ]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
  end 


  
end
