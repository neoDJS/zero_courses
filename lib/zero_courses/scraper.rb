require 'open-uri'
require 'pry'

class ZeroCourses::ScraperZero
  attr_accessor :zero_page # "https://openclassrooms.com/fr/courses"
  def self.scrape_courses_page
    # write your code here
    # This just opens a file and reads it into a variable
    list_courses = self.new.get_courses
    tab = list_courses.collect do |course|
      ash = {}
      ash[:name] = course.css("div.jss380 h5.jss378").text
      ash[:categorie] = course.css("div.jss380 span.jss376").text
      ash[:difficulte] = course.css("div.jss380 p.jss258 span.jss387").first.text
      ash[:duree] = course.css("div.jss380 p.jss258 span.jss387").last.text
      ash[:description] = course.css("div.jss380 p.jss373").text
      ash[:icone_url] = course.css("div.jss379 .jss384").attribute("style").value[/url\((.+)\)/, 1] # "https://course.oc-static.com/courses/5106001/5106001_teaser_picture_1541780159.jpg"
      # ash[:icone_url] = course.css("div.jss379 .jss384").attribute("style").value # 'background-image: url("https://course.oc-static.com/courses/5106001/5106001_teaser_picture_1541780159.jpg");'
      # doc = Nokogiri::HTML('<div class="zoomLens" style="background-image: url(http://resources1.okadirect.com/assets/en/new/catalogue/1200x1200/EHD005MET-L_01.jpg?version=7); background-position: -14.7368421052632px -977.894736842105px; background-repeat: no-repeat;">&nbsp;</div>')
      # doc.search('.zoomLens').map{ |n| n['style'][/url\((.+)\)/, 1] }
      # # => ["http://resources1.okadirect.com/assets/en/new/catalogue/1200x1200/EHD005MET-L_01.jpg?version=7"]
      ash[:profile_url] = course.attribute("href").value
      ash
    end
    # binding.pry
    tab
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

  def get_zero_page
    doc = Nokogiri::HTML(open(self.zero_page))
  end

end