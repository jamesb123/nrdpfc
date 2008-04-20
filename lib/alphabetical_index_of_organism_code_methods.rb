module AlphabeticalIndexOfOrganismCodeMethods
  def self.alphabetical_index_of_organism_code(organism_code, conditions = nil)
    search = Where("organisms.organism_code < ?", organism_code)
    search.and conditions if conditions
    
    count(:conditions => search.to_s, :include => organism_path) + 1
  end
end