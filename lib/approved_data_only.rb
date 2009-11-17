# = Viewing only approved or unapproved data
#
# Users with the data_entry_only flag set true can only see database records
# where approved == false. Other users want to be able to see either or.
#
# This module adds the ActiveScaffold code to limit the page results base
# on the users previous selection and/or their data_entry_only role. Once a
# user visits an approved or unapproved page, their setting will persist as
# they move between pages unless they expilcitly choose the other.
#
# To use this code in your controller just include it after the AS config block.
# You'll also need to add the correct configs in config/tabs.yml:
#  
#  - label: "DNA"  
#    controller: "dna_results"
#    sub_tabs:
#    - label: "Approved DNA Results"	
#      selected_if: 'viewing_approved?'
#      action: 'approved'
#    - label: "Unapproved DNA Results"
#      controller: "dna_results"
#      selected_if: 'viewing_unapproved?'
#      action: 'unapproved'
#
# Don't add anything extra to the top level values. In the sub_tabs section,
# add the following to the appropriate labels, the viewing_(un)approved? helpers
# are defined in app/helpers/application_helpers.rb
#
#  selected_if: 'viewing_approved?'
#  action: 'approved'
#
module ApprovedDataOnly
  def self.included(base)
    base.send :helper_method, :viewing_approved?
  end

  def unapproved
    session[:view_approved_data] = false
    index
  end

  def approved
    session[:view_approved_data] = true
    index
  end

  protected

  def viewing_approved?
    if current_user.data_entry_only
      false
    elsif session[:view_approved_data].nil?
      true
    else
      session[:view_approved_data] == true
    end
  end

  def conditions_for_collection
    approved = viewing_approved?
    table = active_scaffold_config.model.table_name

    ["#{table}.project_id = ? and #{table}.approved = ?", current_project_id, approved ]
  end
end
