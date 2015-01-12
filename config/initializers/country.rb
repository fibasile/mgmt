class Country < ISO3166::Country
  def to_s
    self.translations.any? ? (self.translations["en"] || self.name.split(",").first) : self.name.split(",").first
  end
end
