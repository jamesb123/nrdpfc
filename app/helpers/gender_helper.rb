module GenderHelper
  def options_for_association_conditions(association)
    if association.name == :sample
      # ['samples.project_id = (?)', current_project]
    end
  end
end
