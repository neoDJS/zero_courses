class ZeroCourses::CoursePart
    attr_accessor :time_lines, :title
    @@all_cp = []

    def initialize(part_ash)
        @title = part_ash[:title] 
        part_ash[:time_lines].each{|line|
            t = TimeLine.new(line)
            @time_lines ||= []
            @time_lines < t
        }
        @@all_cp < self
    end

    def self.create_from_collection(coursePart_arr)
        coursePart_arr.map{|part_ash|
            self.new(part_ash)
        }
    end

    def self.all
        @@all_cp
    end
end