module Kinney
  class PeopleController < KinneyController

    def index
      @people_with_images = Person.with_images
      @people_without_images = Person.without_images
    end

    def show
      @person = Person.friendly.find(params[:id])
      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the people_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if !@person.slug.blank? and params[:id] != @person.slug
        return redirect_to @person, :status => :moved_permanently
      end

      @top_image = @person.images.where(:top_pick => true).limit(1).first
      @title = @person.full_name
      @meta_description = @person.short_bio.sub('<p>', '').sub('</p>', '')
    end
  end
end