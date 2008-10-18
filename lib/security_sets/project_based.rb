module SecuritySets
  module ProjectBased
    # In order to use this security set, the model must have:
    #    belongs_to :project

    # This is not an active_scaffold security method, so
    # existing_record_check? doesn't apply here
    def security_settings
      current_user.authorization_display_for self.project
    end

    def authorized_for_create?
      # create is always called on !existing_record_check? 
      check_project = self.respond_to?(:project) && self.project ? self.project : current_project

      current_user.authorized_security_for?(check_project, SecuritySetting::READ_WRITE)
    end
    
    def authorized_for_update?
      current_user.authorized_security_for?(relevant_project, SecuritySetting::READ_WRITE)
    end
    
    def authorized_for_read?
      current_user.authorized_security_for?(relevant_project, SecuritySetting::READ_ONLY)
    end

    def authorized_for_destroy?
      current_user.authorized_security_for?(relevant_project, SecuritySetting::READ_WRITE_DELETE)
    end

    def relevant_project
      (existing_record_check? && self.respond_to?(:project)) ? self.project : current_project
    end
  end
end
