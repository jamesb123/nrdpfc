module MtDnaSeqsHelper
  def sequence_column(record)
    content_tag :div, record.sequence
  end
  def options_for_association_conditions(association)
    if association.name == :locu
      ['locus.project_id = ? AND locus.test_name = ?', current_project, "MtDNASeqs"]
    else
      super
    end
  end
end
