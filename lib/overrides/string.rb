class String
  def titleize_with_id
    [titleize, match(/_id$/) ? "Id" : nil].compact.join(" ")
  end
end