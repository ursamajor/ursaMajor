class Course < ActiveRecord::Base

  acts_as_taggable_on :rules
  has_and_belongs_to_many :semesters

  scope :search_query, lambda { |query| where("name LIKE ?", query) }

  def pnp?
    pnp
  end

  def courses
    [self]
  end

  def dept
    name.match(/^([^.]+)/)[0]
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
