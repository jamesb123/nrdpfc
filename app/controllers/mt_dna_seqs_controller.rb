class MtDnaSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mt_dna_seqs do |config|
    config.columns = [:project, :locus, :haplotype, :sequence, :security_settings ]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
    config.columns[:haplotype].label = "Haplotype"
  end 
  
end
