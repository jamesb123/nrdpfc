module MtDnasHelper
  def options_for_association_conditions(association)
    if association.name == :locu
      ['locus.project_id = ? AND locus.test_name = ?', current_project.id, "mtDNA"]
    else
      super
    end
  end
end
