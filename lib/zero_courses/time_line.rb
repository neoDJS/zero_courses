class ZeroCourses::TimeLine < Page
    @@all_t = []
    
    def initialize(timeLine_hash)
        super(timeLine_hash)
        @@all_t << self
    end

    def self.all
        @@all_t
    end
end