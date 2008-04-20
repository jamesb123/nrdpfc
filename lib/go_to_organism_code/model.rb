module GoToOrganismCode::Model
  def alphabetical_index_of_organism_code(organism_code, conditions = nil)
    search = Where("organisms.organism_code < ?", organism_code)
    search.and conditions if conditions
    count(:conditions => search.to_s, :include => organism_path) + 1
  end
  
  
  protected
    def organism_path
      case
      when self == Organism                                   then []
      when reflections[:organism] || reflections["organism"]  then [:organism]
      when reflections[:sample] || reflections["sample"]      then {:sample => :organism}
      else
        raise "Unable to find path to organism"
      end
    end

end