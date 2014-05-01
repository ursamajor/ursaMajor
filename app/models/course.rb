class Course < ActiveRecord::Base

  acts_as_taggable_on :rules
  has_and_belongs_to_many :semesters

  scope :search_query, lambda { |query| where("name LIKE ?", query) }

  @@dept_mappings = {
    "COMPSCI" => ["CS"],
    "INTEGBI" => ["IB"],
    "MCELLBI" => ["MCB"],
    "IND ENG" => ["IEOR"],
    "BIO ENG" => ["BIO E"],
    "CHM ENG" => ["CHEM E"],
    "EL ENG" => ["EECS", "EE"],
    "MEC ENG" => ["MECH E"],
    "CIV ENG" => ["CIV E"],
    "ENGIN" => ["E"],
    "LNS" => ["L&S"],
    "MAT SCI" => ["MSE"],
    "NUC ENG" => ["NE"],
    "POL SCI" => ["POLI SCI"],
    "POLECON" => ["POLI ECON"],
    "LINGUIS" => ["LING"],
    "STAT" => ["STATS"],
    "NUSCTX" => ["NUTRI SCI", "NST"],
    "PLANTBI" => ["PMB"],
    "COM LIT" => ["COMP LIT"],
    "ASTRON" => ["ASTRO"],
    "AMERSTD" => ["AMST"],
    "ASAMST" => ["ASIAN AM"]
  }

  @@dept_mappings.default = []

  def pnp?
    pnp
  end

  def courses
    [self]
  end

  def dept
    name.match(/^([^.]+)/)[0]
  end

  def postfix
    result = name.match(/([A-Z]+)$/)
    result && result[0]
  end

  def search_dept
    dept_name = dept
    dept.gsub(dept, @@dept_mappings[dept_name][0] || dept_name)
  end

  def search_name
    dept_name = dept
    name.gsub(".", " ").gsub(dept_name, @@dept_mappings[dept_name][0] || dept_name)
  end

  def search_names
    search_names = [search_name]
    dept_name = dept
    @@dept_mappings[dept_name].each do |mapping|
      search_names << name.gsub(".", " ").gsub(dept_name, mapping)
    end
    search_names << title
  end

  def self.add(department)
    uri = "https://apis-dev.berkeley.edu/cxf/asws/course?departmentCode=#{CGI.escape(department)}&_type=xml&app_id=#{ENV['APP_ID']}&app_key=#{ENV['APP_KEY']}"
    begin
      doc = APICaller.call_api(uri)
      courses = doc.xpath("//CanonicalCourse")
      courses.each do |course_info|
        name = course_info.xpath("courseUID").text
        next if Course.find_by name: name
        course = Course.new
        course.name = name
        course.number = name.match(/[\d]+/)[0]
        course.units = course_info.xpath("lowerUnits").text.to_i
        course.title = course_info.xpath("courseTitle").text
        course.description = course_info.xpath("courseDescription").text
        course.save
      end
    rescue => e
      puts "error in course creation: " + e.message
    end
  end

  def self.update_all
    Course.all.each { |course| course.update }
  end

  def self.update_all_after(id)
    Course.all.each { |course| course.update if course.id > id }
  end

  # def self.update_all_with_space
  #   Course.all.each { |course| course.update if course.has_space?}
  # end

  # def has_space?
  #   name[" "]
  # end

  def self.add_back_double_quotes
    Course.all.each do |course|
      if course.description
        course.description = course.description.gsub("<", '"').gsub(">", '"')
        course.save
      end
    end
  end

  def self.remove_double_quotes
    Course.all.each do |course|
      if course.description
        course.description = course.description.gsub('"', "'")
        course.save
      end
    end
  end

  def update
    uri = "https://apis-dev.berkeley.edu/cxf/asws/course?courseUID=#{CGI.escape name}&_type=xml&app_id=#{ENV['APP_ID']}&app_key=#{ENV['APP_KEY']}"
    begin
      doc = APICaller.call_api(uri)
      course_info = doc.xpath("//CanonicalCourse")[0]
      self.title = course_info.xpath("courseTitle").text
      self.description = course_info.xpath("courseDescription").text
      self.save
    rescue => e
      puts "error in course update, course = #{name}: " + e.message
    end
  end

  def self.clear_tags(course_ids)
    course_ids.each do |id|
      course = Course.find_by id: id
      course.rule_list = []
      course.save
    end
  end
  
end
