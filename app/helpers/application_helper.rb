# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def project_form_column(record, input_name)
    projects = current_user.is_admin ?
                 Project.find(:all, :select => "id, name") :
                 current_user.projects

    select_tag('record[project][id]', options_for_select(projects.collect{|project| [project.name, project.id]}, record.project_id), {:id => 'record_project_id', :class => 'project-id-input'})
  end
  
# moved to users helper  
#  def user_form_column(record, input_name)
#    select_tag('record[user][id]', options_for_select(User.find_everybody_but_me.collect{|user| [user.login, user.id]}, record.user_id), {:id => 'record_user_id', :class => 'user-id-input'})
#  end

  def link_to_modal(label, url_options = {}, html_options ={ })
    url = Hash===url_options ? url_for(url_options) : url_options
    popup_options = {
      :width => html_options.delete(:width) || 640,
      :height => html_options.delete(:height) || 480,
      :opacity => html_options.delete(:opacity) || 0.2,
      :position => html_options.delete(:position) || "absolute"
    }
    html_options = html_options.dup
    html_options[:onclick]||=""
    html_options[:onclick]+="; new Control.Modal(this, #{popup_options.to_json}).open(); return false"
    link_to(label, url, html_options)
  end
  
  # Kind of pedantic, but we should:
  # 1) check that someone is logged in
  # 2) there should be a current project set in the session
  # 3) the logged in user should be the project manager of the current project
  def is_project_manager
    user = current_user
    return false if ! user
    return false if ! session[:project_id]
    project = Project.find_by_id(session[:project_id])
    return false if ! project
    @project_manager = (project.user_id == user.id)
  end

  def custom_pagination_links(current_page)
    unless current_page.nil?
      pagination_params = params_for(:action => 'update_table')
      pagination_params.delete(:go_to_organism_code)
      indicator_params = pagination_params.merge(:action => 'pagination')
      previous_url = url_for(pagination_params.merge(:page => current_page.number - 1))
      next_url = url_for(pagination_params.merge(:page => current_page.number + 1))
      current_url = url_for(pagination_params.merge(:page => current_page.number))

      output = ""
      output += render :partial => 'common/go_to_organism_code',
                       :locals => {:current_page => current_page, :pagination_params => pagination_params}
      output += loading_indicator_tag :action => :pagination
      output += link_to_remote(as_('Previous'),
            { :url => pagination_params.merge(:page => current_page.number - 1),
              :after => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'visible';",
              :before => "addActiveScaffoldPageToHistory('#{previous_url}', '#{controller_id}');",
              :complete => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'hidden';",
              :failure => "ActiveScaffold.report_500_response('#{active_scaffold_id}')",
              :update => active_scaffold_content_id,
              :method => :get },
            { :href => previous_url,
              :class => "previous"}) if current_page.prev?
      output += pagination_ajax_links current_page, pagination_params
      output += link_to_remote(as_('Next'),
            { :url => pagination_params.merge(:page => current_page.number + 1),
              :after => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'visible';",
              :before => "addActiveScaffoldPageToHistory('#{next_url}', '#{controller_id}');",
              :complete => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'hidden';",
              :failure => "ActiveScaffold.report_500_response('#{active_scaffold_id}')",
              :update => active_scaffold_content_id,
              :method => :get },
            { :href => next_url,
              :class => "next"}) if current_page.next?
    end
  end

  def columns_per_section(section, divide = 4)
    (section == 'fixed' ? (0..(divide-1)) : ((divide)..100)).to_a
  end

  def row_wrapper_style
    "height:15px;overflow:hidden;"
  end

  def header_wrapper_style
    "height:50px;overflow:hidden;"
  end

  def cb_content(name, &block)
    ivar = "@cb_content_block_#{name}"
    instance_variable_set(ivar, block)
    nil
  end

  def render_cb_content(name, *args)
    ivar = "@cb_content_block_#{name}"
    block = instance_variable_get(ivar)
    block.call(args) unless block.nil?
  end

  def client_browser_name 
                          user_agent = request.env['HTTP_USER_AGENT'].downcase 
                          if user_agent =~ /msie/i 
                                  "Internet Explorer" 
                          elsif user_agent =~ /konqueror/i 
                                  "Konqueror" 
                          elsif user_agent =~ /gecko/i 
                                  "Mozilla" 
                          elsif user_agent =~ /opera/i 
                                  "Opera" 
                          elsif user_agent =~ /applewebkit/i 
                                  "Safari" 
                          else 
                                  "Unknown" 
                          end 
  end 
    
end
