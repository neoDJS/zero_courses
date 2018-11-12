class ZeroCourses::Course
    attr_accessor :name, :categorie, :difficulte, :duree, :description, :icone_url, :profile_url, :home, :course_parts, :certificate
    @@all_c = []

    def initialize(course_ash)
        course_ash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        @@all_c << self
    end

    def self.all
        @@all_c
    end

    def home=(home_ash)
        @home = Home.new(home_ash)
    end

    def course_parts=(coursePart_arr)
        @course_parts = CoursePart.create_from_collection(coursePart_arr)
    end

    def certificate=(certificat_ash)
        @certificate = Certificate.new(certificat_ash)
    end

    def add_attribute(attribute_hash)
        attribute_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
    end
end