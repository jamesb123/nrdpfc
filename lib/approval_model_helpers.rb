module ApprovalModelHelpers
  def self.included(base)
    base.send(:before_save, :assign_approval)
  end

  # set approval flag according to user type
  def assign_approval
    v = read_attribute(:approved)
#    if v.nil? || (! current_user.data_entry_only)
#      write_attribute(:approved, ! current_user.data_entry_only)
    if v.nil? || (current_user.data_entry_only)
      write_attribute(:approved, false)
    else
      if v.nil? || (! current_user.is_admin)
        write_attribute(:approved, true)
      end
    end
  
    # If the method were to return false due to the statement above,
    # saving the record would fail
    true
  end
  
  def approved_authorized?
#    ! current_user.data_entry_only    
     current_user.is_admin    
  end
  
  def approved_authorized_for_update?
    current_user.is_admin    
  end

  def approved_authorized_for_create?
    current_user.is_admin    
  end
end
