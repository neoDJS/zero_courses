class Page
    attr_accessor :url, :content

    def initialize(url, content)
        @content = content
        @url = url
    end
end