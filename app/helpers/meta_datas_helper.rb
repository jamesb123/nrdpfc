module MetaDatasHelper
  def options_for_association_conditions(association)
    if association.name == :sample
      ['project_id = ?', current_project]
    else
      super
    end
  end

  def m_date_added_form_column(record, input_name)
    date_select( :record, :m_date_added, :name => input_name, :include_blank => false )
  end 

end
