class MtDnaSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mt_dna_seqs do |config|
    config.columns = [:project, :locus, :haplotype, :sequence, :accession ]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
  end 
  include ResultTableSharedMethods
  
end
