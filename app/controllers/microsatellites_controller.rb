class MicrosatellitesController < ApplicationController
  layout "tabs"
  active_scaffold :microsatellites do |config|
    config.list.columns = [:id, :project, :sample, :locus, :allele1, :allele2, :gel, :well, :finalResult]
    
    for uc in [config.update, config.create]
      uc.columns = [:id, :project, :sample, :locus, :allele1, :allele2, :gel, :well, :finalResult]
    end

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.list.columns.exclude :id, :project
    columns = config.columns
    columns[:sample].label = "Organism"
    columns[:allele1].label = "Allele-1"
    columns[:finalResult].form_ui = :checkbox
    
    [:project, :gel, :well, :finalResult].each{|c| columns[c].sort = false }
    
    #config.action_links.add('go_to', :label => "Go To...", :page => true) 
    
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
  
  include ResultTableSharedMethods
  include GoToOrganismCode::Controller
  
end
