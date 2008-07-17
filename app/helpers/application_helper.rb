# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def project_form_column(record, input_name)
    select_tag('record[project][id]', options_for_select(current_user.projects.collect{|project| [project.name, project.id]}, record.project_id), {:id => 'record_project_id', :class => 'project-id-input'})
  end
  
  def user_form_column(record, input_name)
    select_tag('record[user][id]', options_for_select(User.find_everybody_but_me.collect{|user| [user.login, user.id]}, record.user_id), {:id => 'record_user_id', :class => 'user-id-input'})
  end

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

    
end
