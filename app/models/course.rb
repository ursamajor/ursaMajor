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
        next if Course.find_by_name name
        course = Course.new
        course.name = name
        course.number = name.match(/[\d]+/)[0]
        course.units = course_info.xpath("lowerUnits").text.to_i
        course.save
      end
    rescue => e
      puts "error in course creation: " + e.message
    end
  end

  def self.clear_tags(course_ids)
    course_ids.each do |id|
      course = Course.find_by_id id
      course.rule_list = []
      course.save
    end
  end
  
end
