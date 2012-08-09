module Kinney
  class MetaSweeper < ActionController::Caching::Sweeper
    observe Clip, Person, Topic, Image
    
    def after_create(obj)
      Rails.cache.clear
    end
    
    def after_update(obj)
      Rails.cache.clear
    end
    
    def after_destroy(obj)
      Rails.cache.clear
    end
  end
end