load "#{RAILS_ROOT}/vendor/plugins/railswhere/lib/where.rb"
load "#{RAILS_ROOT}/vendor/plugins/railswhere/lib/search_builder.rb"
module ResultTableSharedMethods
  def self.included(klass)
    # inject the shared_result_table_views in the front
    klass.generic_view_paths.unshift(File.join(RAILS_ROOT, 'app', 'views', 'shared_result_table_views'))
    klass.send :helper, ResultTableSharedMethods::HelperMethods
  end
  
  def check_all_final_results
    # find all of the records
    do_list
    
    # update them
    @records.each{|r|
      r.finalResult = params[:check_all_finalResults] == "true"
      r.save(false)
    }
    
    render(:partial => 'list', :layout => false)
  end
  
  def check_final_result
    # TODO - secure this method down
    @record = model_for_controller.find(params[:id])
    @record.update_attributes(:finalResult => params[:finalResult])
    render :text => ""
  end
  
  def tablename_for_controller
    model_for_controller.table_name
  end
  
  def model_for_controller
    self.class.active_scaffold_config.model
  end
  
  
  def conditions_from_params
    sb=SearchBuilder.new(params)
    
    # filter to the current project
    if current_project 
      sb.and("#{tablename_for_controller}.project_id = ?", current_project.id)
    else
      # show nothing
      sb.and("false")
    end

    sb.for_table(tablename_for_controller) do
      sb.equal_on("sample_id")
      sb.equal_on("project_id")
      sb.and("finalResult") if params[:finalResult]=="true"
    end

    sb.for_table("samples") do
      sb.equal_on("organism_id")
    end
    
    sb
  end
  
  # a list method that shows without the layout when called via AJAX, making the results controller able to fit inside of a modal dialog
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
  
  module HelperMethods
    def finalResult_column(record)
      check_box_tag "finalResult", "true", record.finalResult, :onchange => remote_function(
        :url => {
          :action => "check_final_result", 
          :id => record.id
        },
        :with => "'finalResult=' + $F(this)"
      )
    end
  end
end