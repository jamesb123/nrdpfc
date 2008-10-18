module SecuritySets
  module AdminOnly
    # Models using this security set only allow admin users
    # to access them in any way

    def authorized_for_create?
      current_user.is_admin
    end
    
    def authorized_for_update?
      current_user.is_admin
      # this method gets called for rows and for Class level questions, so this check returns true at the class level
  #    return true unless existing_record_check?
  #    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE)
    end
    
    def authorized_for_read?
      current_user.is_admin
      # return true unless existing_record_check?
  #    current_user.authorized_security_for?(self.project, SecuritySetting::READ_ONLY)
    end

    def authorized_for_destroy?
      current_user.is_admin
  #    return true
  #    return true unless existing_record_check?
  #    current_user.authorized_security_for?(self.project, SecuritySetting::READ_WRITE_DELETE)
    end

  end
end
