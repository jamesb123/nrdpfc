class MtDnaSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mt_dna_seqs do |config|
    config.columns = [:project, :locus, :haplotype, :accession, :comments, :sequence]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
  end 
  include ResultTableSharedMethods
  
end
