class ::Symbol
  def singularize
    to_s.singularize.to_sym
  end
  
  def pluralize
    to_s.pluralize.to_sym
  end
end