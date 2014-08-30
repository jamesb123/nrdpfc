class MicrosatellitesController < ApplicationController
  layout "tabs"
  active_scaffold :microsatellites do |config|
    config.list.columns = [:project, :sample, :sample_id, :locus, :allele1,
    :allele2, :gel, :well, :comments, :finalResult, :allele_1_peak_height, 
    :allele_2_peak_height, :allele_1_size, :allele_2_size, :date_genotyped]
    
    for uc in [config.update, config.create]
      uc.columns = [:project, :sample_id, :sample, :locu, :allele1, :allele2, :gel, :well, :comments, :finalResult, :allele_1_peak_height, :allele_2_peak_height, :allele_1_size, :allele_2_size, :date_genotyped]
    end

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    # search associated sample colum
    config.columns[:sample].search_sql = 'organisms.organism_code'
    config.search.columns << :sample

    columns = config.columns
    columns[:sample].label = "Organism Code (Sample ID)"
    columns[:sample_id].label = "Sample ID"
    columns[:allele1].label = "Allele 1"
    columns[:allele2].label = "Allele 2"
    columns[:finalResult].form_ui = :checkbox
    columns[:allele_1_peak_height].label = "Allele 1 Peak"
    columns[:allele_2_peak_height].label = "Allele 2 Peak"
    columns[:allele_1_size].label = "Allele 1 Size"
    columns[:allele_2_size].label = "Allele 2 Size"
    config.columns[:locus].label = "Locus"
    config.columns[:sample].form_ui = :record_select
    config.columns[:locu].form_ui = :select
   
    # [:project, :gel, :well, :finalResult].each{|c| columns[c].sort = false }
    
  end
  
  def list
    do_list

    respond_to do |type|
      type.html {
        render :action => 'list', :layout => true
      }
      type.js { 
        do_list
        render :action => 'list', :layout => false 
      }
      type.xml { render :xml => response_object.to_xml, :content_type => Mime::XML, :status => response_status }
      type.json { render :text => response_object.to_json, :content_type => Mime::JSON, :status => response_status }
      type.yaml { render :text => response_object.to_yaml, :content_type => Mime::YAML, :status => response_status }
    end
  end
  
  def conditions_from_params
    sb = super
    
    sb.for_table("microsatellites") do
      sb.equal_on("locus")
    end
    
    sb
  end
  
  include ApprovedDataOnly
  include ResultTableSharedMethods
  include GoToOrganismCode::Controller
  
end
