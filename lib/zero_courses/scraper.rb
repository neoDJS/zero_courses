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

  def self.scrape_certificate_page
    ash = {}
    introPage = self.new.get_zero_page
    ash[:content] = introPage.css("div.textLayer > div").to_a.map(&:to_s).join("\n")
    ash
  end

  def self.scrape_Introduction_page
    ash = {}
    introPage = self.new.get_zero_page
    pageContentData = introPage.css("div.contentWithSidebar__content div.static")
    ash[:title] = pageContentData.css("h2.part-title").text
    ash[:video_url] = pageContentData.css("div.userContent > iframe#video_Player_0").attribute("src").value
    ash[:content] = pageContentData.css("div.userContent > p[data-claire-element-id], div.userContent > div.foldable").to_a.map(&:to_s).join("\n")
    ash[:prerequis] = pageContentData.css("div.userContent aside[data-claire-semantic='information'] p[data-claire-element-id]").to_a.map(&:to_s).join("\n")
    ash[:objectif] = pageContentData.css("div.userContent aside[data-claire-semantic='warning'] p[data-claire-element-id]").to_a.map(&:to_s).join("\n")
    ash[:courseParts] = pageContentData.css("nav li.course-part-summary").map{|part|
      newpart = {}
      newpart[:title] = part.css("secction>a div.course-part-summary__title")
      newpart[:time_lines] = part.css("secction>ol li.course-part-summary__item").map{|line|
        line = {}
        line[:title] = line.css("a").text
        line[:profile_url] = line.css("a").attribute("href").value
      }
    }
    ash
  end

  def self.scrape_time_line_page
    ash = {}
    introPage = self.new.get_zero_page
    pageContentData = introPage.css("div.contentWithSidebar__content div.static")
    ash[:video_url] = pageContentData.css("div.userContent > iframe#video_Player_0").attribute("src").value
    ash[:content] = pageContentData.css("div.userContent > p[data-claire-element-id], div.userContent > div.foldable").to_a.map(&:to_s).join("\n")
    # ash[:prerequis] = pageContentData.css("div.userContent aside[data-claire-semantic='information'] p[data-claire-element-id]").to_a.map(&:to_s).join("\n")
    # ash[:objectif] = pageContentData.css("div.userContent aside[data-claire-semantic='warning'] p[data-claire-element-id]").to_a.map(&:to_s).join("\n")
    ash
  end

  def get_courses
    self.get_zero_page.css("ul.jss276 li.jss372 a")
  end

  def get_zero_page
    doc = Nokogiri::HTML(open(self.zero_page))
  end

end