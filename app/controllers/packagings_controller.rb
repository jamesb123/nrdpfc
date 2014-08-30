class PackagingsController < ApplicationController
  layout "tabs"
  active_scaffold :packagings do |config|
    config.columns = [:medium_short_desc, :medium_long_desc]  
    config.columns[:medium_short_desc].label = "Short Description"  
    config.columns[:medium_long_desc].label = "Long Description"  

    config.update.link.page = false
    config.create.link.page = true
    config.delete.link.page = false

  end

  protected
  def create_authorized?
    current_user&& current_user.is_admin
  end

  def read_authorized?
    current_user && current_user.is_admin
  end

  def update_authorized?
    current_user && current_user.is_admin
  end

  def delete_authorized?
    current_user && current_user.is_admin
  end
end
