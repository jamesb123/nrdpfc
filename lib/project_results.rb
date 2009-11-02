module ProjectResults
  class << self
    def included(base)
      base.class_eval do
        # TODO should bring belongs_to :sample, and :locu in here
        # and validates_presence_of :locu_id, and assign_locus_text(MS)
        
        belongs_to :project
        before_validation_on_create :assign_project_id
        validates_presence_of :project_id, :sample_id
        after_save :flag_project_for_update
      end
    end
  end

  def assign_project_id
    # TODO, clean this up. it should be attached to the sample's project
    value = current_project_id
    self.project_id = value unless value.blank?
  end

  def flag_project_for_update
    self.project.flag_for_update
  end
end
