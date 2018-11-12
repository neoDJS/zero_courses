class Page
    attr_accessor :url, :content, :title

    def initialize(title, url, content)
        @content = content
        @url = url
        @title = title
    end
end