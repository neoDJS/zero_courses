class TimeLine < Page
    attr_accessor :title
    
    def initialize(title, url, content)
        super(url, content)
        self.title = title
    end
end