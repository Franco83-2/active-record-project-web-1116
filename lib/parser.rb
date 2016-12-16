class Parser
  def self.get_from_csv
    CSV.read('goodreads.csv')
  end

  def self.get_keys
    get_from_csv.shift.map {|key| key.downcase}
  end

  def self.get_values
    get_from_csv.drop(1)
  end
end
