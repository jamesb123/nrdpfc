module ProjectManagerAccessOnly

  def create_authorized?
    is_project_manager?
  end

  def read_authorized?
    is_project_manager?
  end

  def update_authorized?
    is_project_manager?
  end

  def delete_authorized?
    is_project_manager?
  end

end