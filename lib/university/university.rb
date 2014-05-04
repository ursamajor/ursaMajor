class University

  @@majors = {
    "Molecular Toxicology" => "CNR",
    "EECS" => "COE"
  }

  def self.get_college(major)
    @@majors[major]
  end

end