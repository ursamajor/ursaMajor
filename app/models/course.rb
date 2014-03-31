class Course < ActiveRecord::Base

  attr_accessible :name, :number, :pnp, :units
  acts_as_taggable_on :rules
  has_and_belongs_to_many :plans

  scope :search_query, lambda { |query| where("name LIKE ?", query) }

  def pnp?
    pnp
  end

  def courses
    [self]
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
  
end
