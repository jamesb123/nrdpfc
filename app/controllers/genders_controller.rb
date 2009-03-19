class GendersController < ApplicationController
  layout "tabs"
  active_scaffold :genders do |config|
    config.columns = [:project, :sample, :sample_id , :gender, :locus, :wellNum, :gelNum, :comments, :finalResult]

    config.columns[:sample].label = "Organism Code (SID)"
    config.columns[:sample_id].label = "Sample ID"
    config.create.columns.exclude :project, :sample_id
    config.update.columns.exclude :project, :sample_id
    config.list.columns.exclude :project

    # search associated sample colum
    config.columns[:sample].search_sql = 'organisms.organism_code'
    config.search.columns << :sample

    config.columns[:sample].sort_by :sql => "organisms.organism_code"
    config.columns[:sample].includes << {:sample => :organism}

    config.columns[:finalResult].form_ui = :checkbox
    config.columns[:sample].form_ui = :record_select
#    config.columns[:sample].form_ui = :select
  
    config.columns[:sample].tooltip = <<-END
    This is a compliation of the "Organism Code" <br>
    and "Organism Sample Index" from the "Sample" table.<br>
    For example, the third sample from individual EGL00001 would be EGL00001-3
    END
    
    config.columns[:sample_id].tooltip = <<-END
    The unique number given to each sample<br>
    by the database in the "Sample" table.
    END

    config.columns[:gender].tooltip = <<-END
    The gender of this sample based on analyses<br/>
    of the locus used and specified in the "Locus" field.
    END
    
    
    config.columns[:locus].tooltip = <<-END
    The locus at which the data in this row are for<br/>
    (e.g. control region, cytochrome b, etc…).
    END

    config.columns[:gelNum].tooltip = <<-END
    The MegaBACE run (or other reference run)<br/>
    containing the raw data for this sample at this locus.
    END

    config.columns[:wellNum].tooltip = <<-END
    The well number on the plate that was analyzed
    END

    config.columns[:finalResult].tooltip = <<-END
    Check this box if you would like the result for this sample at this locus to be the representative of this individual/organism.  Note that you can only check this box for one sample for per individual/organism.
    END

    config.columns[:comments].tooltip = <<-END
    Any comments that you have regarding the mitochondrial DNA data presented in this row.
    END
  end
    

  
  include ResultTableSharedMethods  
  include GoToOrganismCode::Controller

  def conditions_for_collection
    ['genders.project_id = (?)', current_project_id ]
  end  
end
