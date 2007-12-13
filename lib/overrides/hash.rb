class Hash
  def to_a_deep
    map { |key, value| 
      [key, value.is_a?(Hash) ? value.to_a_deep : value]
    }
  end
end