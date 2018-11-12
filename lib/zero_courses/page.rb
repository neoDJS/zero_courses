class ZeroCourses::Page
    attr_accessor :url, :content, :title, :video_url
    @@all = []
    def initialize(page_hash)
        page_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def add_attribute(attr_ash)
        attr_ash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
    end
end