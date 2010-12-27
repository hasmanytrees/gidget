class String
  def slugize
    self.downcase.gsub(/&/, 'and').gsub(/\s+/, '-').gsub(/[^a-z0-9-]/, '')
  end


  def humanize
    self.capitalize.gsub(/[-_]+/, ' ')
  end


  def starts_with?(prefix)
    prefix = prefix.to_s
    self[0, prefix.length] == prefix
  end
end