class Hash
  def to_a_deep
    map { |key, value| 
      [key, value.is_a?(Hash) ? value.to_a_deep : value]
    }
  end
  
  def select_hash(*args, &block)
    select(*args, &block).inject({}) do |h, pair|
      h[pair.first] = pair.last
      h
    end
  end
end
