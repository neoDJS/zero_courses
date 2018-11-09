require 'open-uri'
require 'pry'

class ZeroCourses::Scraper

  def self.scrape_courses_page
    # write your code here
    # This just opens a file and reads it into a variable
    # html = File.read('fixtures/kickstarter.html')

    courses_page = Nokogiri::HTML(open(index_url))
    list_courses = courses_page.css("ul.jss276 li.jss372 a")
    test = list_courses.collect do |course|
      ash = {}
    #   ash[:name] = student.css("div.card-text-container h4.student-name").text
    #   ash[:location] = student.css("div.card-text-container p.student-location").text
    #   ash[:profile_url] = student.attribute("href").value
      ash
    end
    # binding.pry
    test
  end

  def self.scrape_profile_course_page(profile_url)
    ash = {}
    # social = [:twitter, :linkedin, :github]
    # profile = Nokogiri::HTML(open(profile_url))
    # social_media = profile.css("div.social-icon-container a")
    # social_media.each_with_index{|media, i|
    #   social.delete_if{|s|
    #     ash[s] = media.attribute("href").value if media.attribute("href").value.include?(s.to_s)
    #     media.attribute("href").value.include?(s.to_s)
    #   }

    #   ash[:blog] = media.attribute("href").value if !ash.values.include?(media.attribute("href").value) && (i+1==social_media.count)
    # }
    # binding.pry

    # ash[:profile_quote] = profile.css("div.profile-quote").text
    # ash[:bio] = profile.css("div.bio-content p").text
    ash
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  def get_courses
    self.get_page.css("ul.jss276 li.jss372 a")
  end

  def get_page
    doc = Nokogiri::HTML(open("https://openclassrooms.com/fr/courses"))
  end

end