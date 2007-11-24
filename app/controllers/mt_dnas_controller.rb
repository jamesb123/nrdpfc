class MtDnasController < ApplicationController
  layout "tabs"

  active_scaffold :mt_dnas do |config|
    config.columns = [:project, :sample, :locus, :haplotype, :gelNum, :wellNum, :finalResult]
    config.create.columns.exclude :sample, :project
    config.update.columns.exclude :sample, :project
    config.columns[:sample].label = "Sample Info"  
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
    sb=SearchBuilder.new(params)
    
    sb.for_table("microsatellites") do
      sb.equal_on("sample_id")
      sb.equal_on("project_id")
      sb.and("finalResult") if params[:finalResult]=="true"
    end

    sb.for_table("samples") do
      sb.equal_on("organism_id")
    end
    
    sb.to_s
  end
end
