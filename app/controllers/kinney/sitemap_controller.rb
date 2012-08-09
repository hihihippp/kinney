module Kinney
  class SitemapController < KinneyController
    layout nil
    
    def index
      @people = Person.select([:id, :slug, :created_at, :updated_at]).all
      @clips  = Clip.all
      headers["Content-Type"] = "text/xml"
      respond_to do |format|
        format.xml{render :layout => false}
      end
    end
  end
end