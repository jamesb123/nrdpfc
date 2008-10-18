module SecuritySets
  module AdminOnly
    # Models using this security set only allow admin users
    # to access them in any way

    def authorized_for_create?
      current_user.is_admin
    end
    
    def authorized_for_update?
      current_user.is_admin
    end
    
    def authorized_for_read?
      current_user.is_admin
    end

    def authorized_for_destroy?
      current_user.is_admin
    end

  end
end
