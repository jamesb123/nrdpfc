module SecuritySets
  module AllowAll
    # Models using this security set allow all users
    # full access to them

    def authorized_for_create?
      true
    end
    
    def authorized_for_update?
      true
    end
    
    def authorized_for_read?
      true
    end

    def authorized_for_destroy?
      true
    end

  end
end
