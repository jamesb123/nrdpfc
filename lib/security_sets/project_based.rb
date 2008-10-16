module SecuritySets
  module ProjectBased
    # In order to use this security set, the model must have:
    #    belongs_to :project

    def security_settings
      current_user.authorization_display_for self.project
    end

    def authorized_for_create?
      true
    end
    
    def authorized_for_update?
      # this method gets called for rows and for Class level questions, so this check returns true at the class level
      return true unless existing_record_check?
      
      current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE)
    end
    
    def authorized_for_read?
      return true unless existing_record_check?

      current_user.authorized_security_for?(self.project, SecuritySetting::READ_ONLY)
    end

    def authorized_for_destroy?
      return true unless existing_record_check?

      current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE_DELETE)
    end
  end
end
