class MicrosatellitesController < ApplicationController
  layout "tabs"
  active_scaffold :microsatellites do |config|
    config.list.columns = [:id, :project, :sample, :locus, :allele1, :allele2, :gel, :well, :finalResult]
    
    for uc in [config.update, config.create]
      uc.columns = [:id, :project, :sample, :locus, :allele1, :allele2, :gel, :well, :finalResult]
    end
    
    columns = config.columns
    
    columns[:sample].label = "Sample Info"
    columns[:allele1].label = "Allele-1"
    columns[:finalResult].form_ui = :checkbox
    
    [:project, :sample, :gel, :well, :finalResult].each{|c| columns[c].sort = false }
    
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
#      type.xml { render :xml => response_object.to_xml, :content_type => Mime::XML, :status => response_status }
#      type.json { render :text => response_object.to_json, :content_type => Mime::JSON, :status => response_status }
#      type.yaml { render :text => response_object.to_yaml, :content_type => Mime::YAML, :status => response_status }
    end
  end
  
  def conditions_from_params
    sb=SearchBuilder.new(params)
    sb.for_table("microsatellites") do
      sb.equal_on("locus")
      sb.equal_on("sample_id")
      sb.equal_on("project_id")
      sb.and("finalResult") if params[:finalResult]=="true"
    end
    sb.for_table("samples") do 
      sb.equal_on("organism_id")
    end
    
    sb.to_s
  end

  def check_all_final_results
    finalResult = params.delete('finalResult')=="true"
    
    # find all of the records
    do_list
    
    # update them
    @records.each{|r|
      r.finalResult = finalResult
      r.save(false)
    }
    
    render(:partial => 'list', :layout => false)
  end
    
end
