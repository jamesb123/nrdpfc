module GoToOrganismCode::Controller
  def self.included(base)
    base.send :before_filter, :go_to_organism_code
  end
  
  def go_to_organism_code
    if params[:go_to_organism_code]
      # calculate page number
      index = active_scaffold_config.model.alphabetical_index_of_organism_code(params[:go_to_organism_code], conditions_from_params)
      # set params and force sort direction
      params[:page] = ((index-1) / active_scaffold_config.list.per_page) + 1
      params[:sort] = organism_code_column
      params[:sort_direction] = "ASC"
    end
    true
  end
end