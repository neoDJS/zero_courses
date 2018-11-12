class ZeroCourses::Course
    attr_accessor :name, :categorie, :difficulte, :duree, :description, :icone_url, :profile_url, :home, :course_parts, :certificate
    @@all_c = []

    def initialize(course_ash)
        page_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        @@all_c << self
    end

    def self.all
        @@all_c
    end

    def add_attribute_
end