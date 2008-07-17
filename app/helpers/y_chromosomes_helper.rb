module YChromosomesHelper
  def options_for_association_conditions(association)
    if association.name == :sample
      ['project_id = ?', current_project]
    else
      super
    end
  end
end
