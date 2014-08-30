module LocusHelper
  def options_for_association_conditions(association)
    if association.name == :sample
      ['project_id = ?', current_project]
    else
      super
    end
  end

  def test_name_form_column(record, input_name)
    select_tag(input_name, options_for_select( [['Gender', 'Gender'],
    ['mtDNA', 'mtDNA'], 
    ['Microsatellite', 'Microsatellite'], 
    ['MHC','MHC'],
    ['Y-Chromosome','Y-Chromosome'],
    ['SNP','SNP']],  record.test_name))
  end
  
end
