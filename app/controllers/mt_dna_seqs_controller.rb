class MtDnaSeqsController < ApplicationController
  layout "tabs"
  
  active_scaffold :mt_dna_seqs do |config|
    config.columns = [:project, :locu, :locus, :haplotype, :accession, :comments, :sequence]
    config.create.columns.exclude :security_settings, :project
    config.update.columns.exclude :security_settings, :project
    config.columns[:locus].label = "Text Locus"
    config.columns[:locu].label = "Lookup Locus"
    config.columns[:locu].form_ui = :select  
  end  
  include ResultTableSharedMethods
end
