module Kinney
  class SearchController < KinneyController
    def index
      if params[:q].present?
        @query = params[:q]
        @fallback_clips = false
        @fallback_people = false
        @clips = Clip.tire.search :load => true do |search|
          search.query do |query|
             query.string @query
          end
        end
        @people = Person.tire.search :load => true do |search|
          search.query do |query|
             query.string @query
          end
          search.sort {by :last_name, 'asc'}
        end

        if @clips.blank?
          clips_fallback
          @fallback_clips = true
        end
        if @people.blank?
          people_fallback
          @fallback_people = true
        end

      else # show some top pick clips
        clips_fallback
        people_fallback
      end
    end

    private

    def clips_fallback
      @clips = Clip.where(:top_pick => true).limit(10)
    end

    def people_fallback
      @people = Person.with_clips
    end
  end
end