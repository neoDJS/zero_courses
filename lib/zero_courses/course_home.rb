class ZeroCourses::Home < Page
    attr_accessor :prerequis, :objectif
    def initialize(home_hash)
        page_ash = {}
        home_hash.each do |attribute, value|
            page_ash[attribute] = value if attribute != :prerequis && attribute != :objectif
        end
        super(home_hash)
        @prerequis = home_hash[:prerequis]
        @objectif = home_hash[:objectif]
    end
end